require 'savon'

module CnpOneClick
  class CardRegistrationDelete

    PERMITTED_PARAMS = %i(merchant_id user_id card_id wsdl endpoint)
    REQUIRED_PARAMS  = %i(merchant_id user_id card_id wsdl endpoint)
    RESPONSE_PARAMS  = %i(success)

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
      request = client.call(:delete_card_registration, message: hash_to_send )
      response(request.body[:delete_card_registration_response][:return])
    end

    def response(true_or_false)
      @success = true_or_false
    end
  end
end
