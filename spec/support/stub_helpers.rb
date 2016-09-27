module StubHelpers

  ENDPOINT = 'https://test.processing.kz/CNPOneClickMerchantWebServices/services/CNPOneClickMerchantWebService.CNPOneClickMerchantWebServiceHttpSoap12Endpoint'

  def stub_start_card_registration_request
    stub_request(:post, ENDPOINT).to_return(status: 200, body: File.new('spec/fixtures/start_card_registration_response.xml'))
  end

  def stub_complete_card_registration_false_request
    stub_request(:post, ENDPOINT).to_return(status: 200, body: File.new('spec/fixtures/complete_card_registration_false_response.xml'))
  end

  def stub_complete_card_registration_true_request
    stub_request(:post, ENDPOINT).to_return(status: 200, body: File.new('spec/fixtures/complete_card_registration_true_response.xml'))
  end
end
