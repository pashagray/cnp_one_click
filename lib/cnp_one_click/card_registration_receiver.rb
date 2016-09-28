module CnpOneClick
  class CardRegistrationReceiver

    attr_reader :user_login, :user_id, :card_id, :pan_masked, :card_status

    def initialize(http_xml_body)
      xml_doc = Nokogiri::XML(http_xml_body)
      @user_login  = xml_doc.css('notice userLogin').text
      @user_id     = xml_doc.css('notice userId').text
      @card_id     = xml_doc.css('notice cardId').text
      @pan_masked  = xml_doc.css('notice panMasked').text
      @card_status = xml_doc.css('notice cardStatus').text.downcase
    end
  end
end
