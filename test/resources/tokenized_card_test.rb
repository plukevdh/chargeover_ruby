require_relative '../test_helper'

class TokenizedCardTest < ChargoverRubyTest
  def test_exists
    assert Chargeover::TokenizedCard
  end

  def test_should_create_a_tokenized_card
    VCR.use_cassette('create_tokenized_card', :match_requests_on => [:anonymized_uri]) do
      customer = Chargeover::Customer.find(35)
      tokenized_card = Chargeover::TokenizedCard.create(
          customer_id: customer.customer_id,
          type: 'customer',
          token: 'cus_1CoGUjtUMyLIDR'
      )
      assert tokenized_card
    end
  end
end
