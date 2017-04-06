module CurrencyConverter3000
  class Money
    attr_reader :currency

    class << self
      # Setup the Default Currency and the coresponding conversion rates
      def conversion_rates default_currency, conversion_hash
        @@default_currency = default_currency
        # Hash of conversion rates from Default Currency
        # Each key should represent a currency
        # Each value should represent the rate of conversion
        # Example :
        # {
        #   'USD' => 1.10,
        #   'BTC' => 0.00091
        # }
        @@conversion_hash = conversion_hash
      end
    end

    def initialize amount, currency
      @amount = amount
      @currency = currency
    end

    # These are the 4 Covered Conversion cases:
    # Currency -> Default Currency
    # Same Currency -> Same Currency
    # Currency -> New Currency
    # Default Currency -> Currency
    def convert_to new_currency
      if new_currency == @@default_currency && new_currency != @currency
        # convert from non default currency to default currency
        Money.new @amount / @@conversion_hash[@currency], new_currency
      elsif new_currency == @currency
        # convert from non default currency to same non default currency
        self
      elsif new_currency != @@default_currency && @currency != @@default_currency
        # convert from non default currency to other non default currency
        # Currency -> Default Currency
        # Default Currency -> New Currency
        convert_to(@@default_currency).convert_to(new_currency)
      elsif @@conversion_hash[new_currency]
        # convert from default currency to non default currency
        Money.new @amount * @@conversion_hash[new_currency], new_currency
      end
    end

    def amount
      @amount.to_f.round(2)
    end

    def + money_object
      (amount + money_object.convert_to(@currency).amount).round(2)
    end

    def - money_object
      (amount - money_object.convert_to(@currency).amount).round(2)
    end

    def * number
      (amount * number).round(2)
    end

    def / number
      (amount / number).round(2)
    end

    def == money_object
      if @currency == money_object.currency
        amount == money_object.amount
      else
        amount == money_object.convert_to(@currency).amount
      end
    end

    def > money_object
      if @currency == money_object.currency
        amount > money_object.amount
      else
        amount > money_object.convert_to(@currency).amount
      end
    end

    def < money_object
      if @currency == money_object.currency
        amount < money_object.amount
      else
        amount < money_object.convert_to(@currency).amount
      end
    end

    def inspect
      "#{sprintf('%.2f', @amount)} #@currency"
    end
  end
end
