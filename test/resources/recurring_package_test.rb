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
end