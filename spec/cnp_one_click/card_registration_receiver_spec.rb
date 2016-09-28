require 'spec_helper'

describe CnpOneClick::CardRegistrationReceiver do

  describe '#new' do
    { user_login: 'ivanov@mail.com',
      user_id: '102',
      card_id: '87',
      pan_masked: '401267******1018',
      card_status: 'uncompleted'
    }.each do |key, val|
      it "parses body and sets #{key} properly" do
        expect(described_class.new(File.new('spec/fixtures/reg_card.xml').read).send(key)).to eq(val)
      end
    end
  end
end
