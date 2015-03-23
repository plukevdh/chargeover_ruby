module Chargeover
  class CreditCard < Resource

    self.prefix = '/creditcard'

    attr_accessor :creditcard_id,
        :external_key,
        :type,
        :token,
        :expdate,
        :write_datetime,
        :write_ipaddr,
        :mask_number,
        :name,
        :expdate_month,
        :expdate_year,
        :expdate_formatted,
        :type_name,
        :customer_id

  end
end
