module Chargeover
  class TokenizedCard < Resource

    self.prefix = '/tokenized'

    attr_accessor :tokenized_id,
                  :type,
                  :token,
                  :customer_id

  end
end
