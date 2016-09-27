require 'spec_helper'

describe CnpOneClick::CardRegistrationStart do

  describe '#new' do

    before do
      CnpOneClick.configure(
        merchant_id: '777000000000018',
        language_code: 'en',
        currency_code: 398,
        wsdl: 'spec/CNPOneClickMerchantWebService.wsdl',
        endpoint: 'https://test.processing.kz:443/CNPOneClickMerchantWebServices/services/CNPOneClickMerchantWebService.CNPOneClickMerchantWebServiceHttpSoap12Endpoint'
        )
    end

    context 'when not all required params are presented' do
      it 'raises error' do
        expect do
          described_class.new
        end.to raise_error(StandardError).with_message('[:user_login, :return_u_r_l] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      it 'returns url for registration new card' do
        expect(described_class.new(return_u_r_l: ':3000', user_login: 'test@test.io').redirect_url).to start_with('https://test.processing.kz/CNPConsumerWebsite/RequestCardholderDetails')
      end
    end
  end
end
