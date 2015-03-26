module Chargeover
  class Transaction < Resource

    self.prefix = '/transaction'

    attr_accessor :transaction_id,
                  :gateway_id,
                  :currency_id,
        :token,
        :transaction_date,
        :gateway_status,
        :gateway_transid,
        :gateway_msg,
        :amount,
        :fee,
        :transaction_type,
        :transaction_method,
        :transaction_detail,
        :transaction_datetime,
        :transaction_type_name,
        :currency_symbol,
        :currency_iso4217,
        :customer_id,
        :applied_to

  end
end