require 'savon'

module CnpOneClick
  class CardRegistrationStart

    PERMITTED_PARAMS = %i(merchant_id terminal_id user_login user_id currency_code
                          language_code return_u_r_l wsdl endpoint)
    REQUIRED_PARAMS  = %i(merchant_id user_login language_code return_u_r_l wsdl endpoint)
    RESPONSE_PARAMS  = %i(success redirect_url error_code error_description user_id)

    attr_reader *(PERMITTED_PARAMS + RESPONSE_PARAMS)

    def initialize(params = {})
      CnpOneClick.config
                 .to_h
                 .merge(params)
                 .select { |p| PERMITTED_PARAMS.include?(p) }
                 .each { |p| instance_variable_set("@#{p[0]}", p[1])}
      if missing_params.any?
        raise StandardError, "#{missing_params} is required, but not set"
      else
        request!
      end
    end

    def missing_params
      REQUIRED_PARAMS - REQUIRED_PARAMS.map { |p| p.to_sym if send(p) }
    end

    def hash_to_send
      PERMITTED_PARAMS.map { |p| [p, send(p)] }.to_h
    end

    def request!
      client = Savon.client(wsdl: wsdl, soap_version: 2, endpoint: endpoint)
      request = client.call(:start_card_registration, message: { registration: hash_to_send })
      response(request.body[:start_card_registration_response][:return])
    end

    def response(args = {})
      args.each { |p| instance_variable_set("@#{p[0]}", p[1]) if respond_to?(p[0])}
    end
  end
end
