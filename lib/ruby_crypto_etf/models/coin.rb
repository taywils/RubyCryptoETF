module RubyCryptoETF
  class Coin
    attr_reader :symbol
    attr_reader :amount
    attr_reader :exchange
    attr_reader :value

    def initialize(args = {})
      @symbol = args[:symbol] || ""
      @amount = args[:amount] || BigDecimal("0")
      @exchange = args[:exchange] || ""
      @value = args[:value] || BigDecimal("0")

      if @amount.class != BigDecimal
        @amount = BigDecimal(amount.to_s)
      end

      if @value.class != BigDecimal
        @value = BigDecimal(value.to_s)
      end

      @amount = BigDecimal("0") if @amount < BigDecimal("0")
      @value = BigDecimal("0") if @value < BigDecimal("0")

      @symbol.to_s.upcase!
      @exchange.to_s.downcase!
    end

    def amount=(new_amount)
      if new_amount.class != BigDecimal
        new_amount = BigDecimal(new_amount.to_s)
      end
      @amount = new_amount if new_amount > BigDecimal("0")
    end

    def value=(new_value)
      if new_value.class != BigDecimal
        new_value = BigDecimal(new_value.to_s)
      end
      @value = new_value if new_value > BigDecimal("0")
    end

    def to_h
      { symbol: @symbol, amount: @amount, exchange: @exchange, value: @value }
    end
  end
end
