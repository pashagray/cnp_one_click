require 'spec_helper'

describe CnpOneClick do

  it 'sets and returns configuration properly' do
    CnpOneClick.configure(merchant_id: 1000)
    expect(CnpOneClick.config.merchant_id).to eq(1000)
  end
end
