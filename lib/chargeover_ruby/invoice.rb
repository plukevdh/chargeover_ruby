module Chargeover

  class Invoice < Resource

    self.prefix = '/invoice'

    attr_accessor :invoice_id,
        :currency_id,
        :terms_id,
        :token,
        :refnumber,
        :bill_addr1,
        :bill_addr2,
        :bill_addr3,
        :bill_city,
        :bill_state,
        :bill_country,
        :bill_postcode,
        :bill_notes,
        :ship_addr1,
        :ship_addr2,
        :ship_addr3,
        :ship_city,
        :ship_state,
        :ship_country,
        :ship_postcode,
        :ship_notes,
        :custom_1,
        :custom_2,
        :custom_3,
        :currency_symbol,
        :currency_iso4217,
        :invoice_status_name,
        :invoice_status_str,
        :invoice_status_state,
        :total,
        :credits,
        :payments,
        :sum_base,
        :sum_usage,
        :sum_onetime,
        :is_paid,
        :balance,
        :is_void,
        :due_date,
        :terms_name,
        :terms_days,
        :days_overdue,
        :is_overdue,
        :date,
        :bill_block,
        :ship_block,
        :url_permalink,
        :url_paylink,
        :url_pdflink,
        :package_id,
        :customer_id,
        :line_items


private

    attr_writer :write_datetime
  end


end