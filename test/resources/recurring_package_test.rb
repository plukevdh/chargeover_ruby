require_relative '../test_helper'

class RecurringPackageTest < ChargoverRubyTest
  def test_exists
    assert Chargeover::RecurringPackage
  end

  def test_should_return_a_recurring_package_by_id
    VCR.use_cassette('one_recurring_package', :match_requests_on => [:anonymized_uri]) do
      package = Chargeover::RecurringPackage.find(554)

      assert_equal Chargeover::RecurringPackage, package.class
    end
  end

  def test_should_return_package_line_items
    VCR.use_cassette('one_recurring_package_with_items', :match_requests_on => [:anonymized_uri]) do
      package = Chargeover::RecurringPackage.find(555)

      assert_equal 1, package.items.length
      assert_equal Chargeover::LineItem, package.items.first.class
      assert_equal Chargeover::Item, package.items.first.item.class
    end
  end

  def test_should_return_credit_card_details
    VCR.use_cassette('recurring_package_with_credit_card', :match_requests_on => [:anonymized_uri]) do
      package = Chargeover::RecurringPackage.find(566)

      assert_equal Chargeover::CreditCard, package.credit_card.class
    end
  end

  def test_should_upgrade_a_package
    VCR.use_cassette('upgrade_a_package', :match_requests_on => [:anonymized_uri]) do
      package = Chargeover::RecurringPackage.find(555)
      line_item = package.items.first
      new_item = Chargeover::Item.find_by_external_key('super')
      updated_package = package.upgrade(line_item.line_item_id, new_item.item_id)
      assert_equal Chargeover::RecurringPackage, updated_package.class
      assert_equal new_item.item_id, updated_package.items.first.item_id
    end
  end

  def test_should_update_next_invoice_date
    VCR.use_cassette('update_package_invoice_date', :match_requests_on => [:anonymized_uri]) do
      package = Chargeover::RecurringPackage.find(555)
      assert DateTime.parse('2015-03-24') != package.next_invoice_datetime
      updated_package = package.update_hold_date('2015-03-24')
      assert_equal DateTime.parse('2015-03-24'), updated_package.next_invoice_datetime
    end
  end

end