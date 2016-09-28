require 'spec_helper'

describe CnpOneClick::Receiver do

  describe '#new' do
    context 'when xml is reg_card' do
      it 'returns CardRegistrationReceiver instance' do
        expect(described_class.parse(File.new('spec/fixtures/reg_card.xml').read).class).to eq(CnpOneClick::CardRegistrationReceiver)
      end
    end
  end
end
