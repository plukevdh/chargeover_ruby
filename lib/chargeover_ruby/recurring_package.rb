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
                  :item_type,
                  :holduntil_datetime

    def self.find_all_by_customer_id(customer_id)
      response = get(base_url + "?where=customer_id:EQUALS:#{customer_id}")
      packages = []
      response.each do |package|
        packages << RecurringPackage.find(package['package_id'])
      end
      packages
    end

    def items
      unless @items
        @items = []
        self.line_items.each do |line_item|
          @items << Chargeover::LineItem.new(line_item)
        end
      end
      @items
    end

    def credit_card
      unless @credit_card
        if self.creditcard_id
          @credit_card = Chargeover::CreditCard.find(self.creditcard_id)
        end
      end
      @credit_card
    end


    def upgrade(old_line_item_id, new_item_id, prorate = true)
      data = {
          line_items: [
              line_item_id: old_line_item_id,
              item_id: new_item_id,
              subscribe_prorate: prorate,
              cancel_prorate: prorate
        ]
      }

      response = post(base_url + "/#{self.package_id}?action=upgrade", data)

      if response
        Chargeover::RecurringPackage.find(self.package_id)
      else
        nil
      end
    end


    def update_hold_date(hold_date)
      response = post(base_url + "/#{self.package_id}?action=hold", { holduntil_datetime: hold_date })
      Chargeover::RecurringPackage.find(self.package_id)
    end

private

    attr_writer :write_datetime, :mod_datetime, :currency_symbol, :currency_iso4217

  end
end