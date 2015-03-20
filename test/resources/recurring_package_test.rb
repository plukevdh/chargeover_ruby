require_relative '../test_helper'

class RecurringPackageTest < ChargoverRubyTest
  def test_exists
    assert Chargeover::RecurringPackage
  end

  def test_should_return_a_recurring_package_by_id
    VCR.use_cassette('one_recurring_package', :match_requests_on => [:anonymized_uri]) do
      item = Chargeover::RecurringPackage.find(554)

      assert_equal Chargeover::RecurringPackage, item.class
    end
  end
end