require 'test_helper'

class CurrencyConverter3000Test < Minitest::Test

  def setup
    CurrencyConverter3000::Money.conversion_rates('EUR', {
      'USD' => 1.11,
      'BTC' => 0.00091
    })
    @eur_money = CurrencyConverter3000::Money.new 40, 'EUR'
    @usd_money = CurrencyConverter3000::Money.new 10, 'USD'
  end

  def test_it_does_create_objects
    assert @eur_money
  end

  def test_it_has_reader_methods
    assert_equal @eur_money.amount, 40
    assert_equal @eur_money.currency, 'EUR'
  end

  def test_it_has_a_valid_inspect_output
    assert_equal @eur_money.inspect, "40.00 EUR"
  end

  def test_it_can_convert_to_different_currency
    # test conversion from default currency to other currency
    assert_equal @eur_money.convert_to('USD').inspect, "44.40 USD"
    # test conversion from non default currency to default currency
    assert_equal @usd_money.convert_to('EUR').inspect, "9.01 EUR"
    # test conversion from non default currency to non default currency
    assert_equal @usd_money.convert_to('BTC').inspect, "0.01 BTC"
  end

  def test_it_returns_another_eur_money_object
    new_eur_money = @eur_money.convert_to('USD')
    assert_equal new_eur_money.class, CurrencyConverter3000::Money
  end

  def test_addition_method
    assert_equal @eur_money + @usd_money, 49.01
  end

  def test_substraction_method
    assert_equal @eur_money - @usd_money, 30.99
  end

  def test_division_method
    assert_equal @eur_money / 7, 5.71
  end

  def test_multiply_method
    assert_equal @eur_money * 3, 120
  end

  def test_comparisson_method
    usd_money = CurrencyConverter3000::Money.new 44.40, 'USD'
    assert_equal @eur_money == @usd_money, false
    assert_equal usd_money == @eur_money, true
    assert_equal usd_money > @eur_money, false
    assert_equal usd_money < @eur_money, false
    assert_equal @eur_money > @usd_money, true
    assert_equal @eur_money < @usd_money, false
  end
end
