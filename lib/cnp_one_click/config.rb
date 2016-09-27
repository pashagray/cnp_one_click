require 'ostruct'

module CnpOneClick

  class << self
    attr_reader :config
  end

  def self.configure(params = {})
    @config = OpenStruct.new(params)
  end
end
