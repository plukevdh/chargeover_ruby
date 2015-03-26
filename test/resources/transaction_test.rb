require_relative '../test_helper'

class TransactionTest < ChargoverRubyTest
  def test_exists
    assert Chargeover::Transaction
  end

  def test_should_return_all_transactions
    VCR.use_cassette('list_transactions', :match_requests_on => [:anonymized_uri]) do
      transactions = Chargeover::Transaction.all
      assert Chargeover::Transaction, transactions.first.class
      assert 5, transactions.length
    end
  end

  def test_should_return_information_on_credit
    VCR.use_cassette('one_credit', :match_requests_on => [:anonymized_uri]) do
      transaction = Chargeover::Transaction.find(79)
      assert Chargeover::Transaction, transaction.class
      assert 'crd', 'transaction_type'
    end
  end


  def test_should_create_a_credit
    VCR.use_cassette('create_one_credit', :match_requests_on => [:anonymized_uri]) do
      transaction = Chargeover::Transaction.create(
          customer_id: 18,
          transaction_type: 'cre',
          gateway_method: 'credit',
          amount: '42.50',
          gateway_status: 1,
          gateway_transid: 'API Credit',
          transaction_detail: 'Credit for unused Image Relay Small'
      )
      assert Chargeover::Transaction, transaction.class
      assert 'crd', 'transaction_type'
      assert_equal 42.50, transaction.amount
    end
  end

  def test_should_create_a_credit_and_apply_to_invoice
    VCR.use_cassette('create_and_apply_credit', :match_requests_on => [:anonymized_uri]) do
      invoice = Chargeover::Invoice.find(10027)
      assert_equal 500.00, invoice.balance
      transaction = Chargeover::Transaction.create(
          customer_id: 18,
          transaction_type: 'cre',
          gateway_method: 'credit',
          amount: '42.50',
          gateway_status: 1,
          gateway_transid: 'API Credit',
          transaction_detail: 'Credit for unused Image Relay Small',
          applied_to: [{
            invoice_id: 10027
          }]
      )
      assert Chargeover::Transaction, transaction.class
      assert 'crd', 'transaction_type'
      assert_equal 42.50, transaction.amount

      invoice = Chargeover::Invoice.find(10027)
      assert_equal 500.00 - 42.50, invoice.balance
    end
  end

end