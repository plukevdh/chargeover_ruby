module Chargeover
  class Item < Resource

    self.prefix = '/item'

    attr_reader :item_id, :units_plural

    attr_accessor :item_type,
                  :tierset_id,
                  :name,
                  :description,
                  :units,
                  :accounting_sku,
                  :external_key,
                  :token,
                  :custom_1,
                  :custom_2,
                  :custom_3,
                  :service_data,
                  :tiersets,
                  :categories

private

    attr_writer :item_id, :write_datetime, :mod_datetime, :units_plural

  end
end