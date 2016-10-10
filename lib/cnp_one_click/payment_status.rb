require 'savon'

module CnpOneClick
  class PaymentStatus

    PERMITTED_PARAMS = %i(merchant_id user_id customer_reference wsdl endpoint)
    REQUIRED_PARAMS  = %i(merchant_id user_id customer_reference wsdl endpoint)
    RESPONSE_PARAMS  = %i(transaction_status transaction_currency_code
                          amount_requested amount_authorized amount_settled
                          amount_refunded goods additional_information auth_code
                          purchaser_name merchant_local_date_time merchant_online_address
                          bank_r_r_n issuer_bank rsp_code rsp_code_desc)

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
      request = client.call(:get_payment_status, message: hash_to_send )
      response(request.body[:get_payment_status_response][:return])
    end

    def response(args = {})
      args.each { |p| instance_variable_set("@#{p[0]}", p[1]) if respond_to?(p[0])}
    end
  end
end
