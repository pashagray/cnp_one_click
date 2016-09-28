module CnpOneClick
  class Receiver
    def self.parse(http_xml_body)
      xml_doc = Nokogiri::XML(http_xml_body)
      case xml_doc.css('notice').attr('type').to_s
      when 'REG_CARD'
        CnpOneClick::CardRegistrationReceiver.new(http_xml_body)
      else
        raise NotImplementedError
      end
    end
  end
end
