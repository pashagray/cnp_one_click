require 'spec_helper'

describe CnpOneClick::CardRegistrationComplete do

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
        end.to raise_error(StandardError).with_message('[:user_id, :card_id, :test_amount] is required, but not set')
      end
    end

    context 'when all required params are presented' do
      context 'when provided data is wrong' do
        it 'returns false' do
          stub_complete_card_registration_false_request
          expect(described_class.new(user_id: 3372, card_id: 2246, test_amount: 1012).success).to eq(false)
        end
      end

      context 'when provided data is correct' do
        it 'returns true' do
          stub_complete_card_registration_true_request
          expect(described_class.new(user_id: 3372, card_id: 2246, test_amount: 1012).success).to eq(true)
        end
      end
    end
  end
end
