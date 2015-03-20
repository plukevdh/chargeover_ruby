module Chargeover
  class ChargeoverException < StandardError

    attr_accessor :status

    def initialize(status, message = nil)
      @status = status
      @message = message
      @default_message = 'There was an error with chargeover'
    end

    def to_s
      @message || @default_message
    end
  end
end