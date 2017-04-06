module CurrencyConverter3000
  class Money
    attr_reader :amount, :currency

    class << self
      def conversion_rates default_currency, conversion_hash
        @@default_currency = default_currency
        @@conversion_hash = conversion_hash
      end
    end

    def initialize amount, currency
      @amount = amount
      @currency = currency
    end

    def convert_to currency
      if @@conversion_hash[currency]
        Money.new @amount * @@conversion_hash[currency], currency
      else
        'No conversion rate found.'
      end
    end

    def + money_object
      @amount + @@conversion_hash[money_object.currency]*money_object.amount
    end

    def - money_object
      @amount - @@conversion_hash[money_object.currency]*money_object.amount
    end

    def * number
      @amount * number
    end

    def / number
      @amount / number
    end

    def == money_object
      if @currency == money_object.currency
        @amount.round(2) == money_object.amount.round(2)
      else
        @amount.round(2) == (@@conversion_hash[money_object.currency] * money_object.amount).round(2)
      end
    end

    def inspect
      "#{sprintf('%.2f', @amount)} #@currency"
    end
  end
end
