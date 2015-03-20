require_relative '../test_helper'

class ItemTest < ChargoverRubyTest
  def test_exists
    assert Chargeover::Item
  end

  def test_should_find_an_item_by_id
    VCR.use_cassette('one_item', :match_requests_on => [:anonymized_uri]) do
      item = Chargeover::Item.find(4)

      assert_equal Chargeover::Item, item.class

      assert_equal 'service', item.item_type
      assert_equal 'Image Relay Small Plan', item.name
    end
  end

  def test_should_create_an_item
    VCR.use_cassette('create_item', :match_requests_on => [:anonymized_uri]) do
      item = Chargeover::Item.create(
                                 type: 'service',
                                 name: 'Test Product',
                                 pricemodel: {
                                     base: 100.99,
                                     paycycle: 'mon',
                                     pricemodel: 'fla'
                                 }
      )

      assert_equal Chargeover::Item, item.class

      assert_equal 'service', item.item_type
      assert_equal 'Test Product', item.name
    end
  end

  def test_should_find_and_item_by_external_id
    VCR.use_cassette('item_by_external_id', :match_requests_on => [:anonymized_uri]) do
      item = Chargeover::Item.find_by_external_key('my_external_id')

      assert_equal Chargeover::Item, item.class

      assert_equal 'service', item.item_type
      assert_equal 'Test Product', item.name
    end
  end

  def test_should_return_all_items
    VCR.use_cassette('item_list', :match_requests_on => [:anonymized_uri]) do
      items = Chargeover::Item.all

      assert_respond_to items, :length
      assert_respond_to items, :each
      assert_equal 5, items.length
      assert_equal Chargeover::Item, items.first.class
    end
  end

end