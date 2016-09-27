require 'savon'

module CnpOneClick
  class CardRegistrationStart

    PERMITTED_PARAMS = %i(merchant_id terminal_id user_login user_id currency_code
                          language_code return_u_r_l wsdl endpoint)
    REQUIRED_PARAMS  = %i(merchant_id user_login language_code return_u_r_l wsdl endpoint)
    RESPONSE_PARAMS  = %i(success redirect_url error_code error_description user_id)

    attr_reader :params

    def initialize(params = {})
      @params = CnpOneClick.config
                           .to_h
                           .merge(params)
                           .select{ |param| PERMITTED_PARAMS.include?(param) }
      if missing_params.any?
        raise StandardError, "#{missing_params} is required, but not set"
      else
        request!
      end
    end

    def missing_params
      REQUIRED_PARAMS.reject { |param| params.include?(param) }
    end

    def request!
      client = Savon.client(wsdl: params[:wsdl], soap_version: 2, endpoint: params[:endpoint])
      request = client.call(:start_card_registration,
                            message: { registration: params.reject { |p| [:wsdl, :endpoint].include?(p) } })
      response(request.body[:start_card_registration_response][:return])
    end

    def response(args = {})
      @params = @params.merge(args)
    end

    def redirect_url
      params[:redirect_url]
    end
  end
end
