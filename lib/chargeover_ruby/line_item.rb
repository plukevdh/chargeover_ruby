module Chargeover
  class LineItem < Resource

    attr_accessor :item_id,
                  :tierset_id,
                  :external_key,
                  :nickname,
                  :descrip,
                  :trial_days,
                  :trial_units,
                  :custom_1,
                  :custom_2,
                  :custom_3,
                  :subscribe_datetime,
                  :expire_recurs,
                  :license,
                  :item_name,
                  :item_external_key,
                  :item_accounting_sku,
                  :item_units,
                  :line_item_id,
                  :tierset

    def item
      @item ||= Chargeover::Item.find(self.item_id)
    end

  end
end