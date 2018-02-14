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
      @amount = new_amount if new_amount > BigDecimal("0")
    end

    def value=(new_value)
      @value = new_value if new_value > BigDecimal("0")
    end
  end
end
