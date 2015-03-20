module Chargeover
  class RecurringPackage < Resource

    self.prefix = '/package'

    attr_accessor :terms_id,
                  :currency_id,
                  :external_key,
                  :token,
                  :nickname,
                  :paymethod,
                  :paycycle,
                  :bill_addr1,
                  :bill_addr2,
                  :bill_addr3,
                  :bill_city,
                  :bill_state,
                  :bill_postcode,
                  :bill_country,
                  :bill_notes,
                  :ship_addr1,
                  :ship_addr2,
                  :ship_addr3,
                  :ship_city,
                  :ship_state,
                  :ship_country,
                  :ship_postcode,
                  :ship_notes,
                  :creditcard_id,
                  :ach_id,
                  :tokenized_id,
                  :custom_1,
                  :custom_2,
                  :custom_3,
                  :amount_collected,
                  :amount_invoiced,
                  :amount_due,
                  :next_invoice_datetime,
                  :package_id,
                  :customer_id,
                  :package_status_id,
                  :package_status_name,
                  :package_status_str,
                  :package_status_state,
                  :line_items,
                  :item_type

    def self.find_all_by_customer_id(customer_id)
      response = get(base_url + "?where=customer_id:EQUALS:#{customer_id}")
      packages = []
      response.each do |package|
        packages << new(package)
      end
      packages
    end

private

    attr_writer :write_datetime, :mod_datetime, :currency_symbol, :currency_iso4217

  end
end