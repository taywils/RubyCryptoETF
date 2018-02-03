module RubyCryptoETF
  class Coin
    attr_reader :symbol
    attr_reader :amount
    attr_reader :exchange

    def initialize(args = {})
      @symbol = args[:symbol] || ""
      @amount = args[:amount] || BigDecimal("0")
      @exchange = args[:exchange] || ""

      if @amount.class != BigDecimal
        @amount = BigDecimal(amount.to_s)
      end

      @amount = BigDecimal("0") if @amount < BigDecimal("0")

      @symbol.to_s.upcase!
      @exchange.to_s.downcase!
    end

    def add_amount(new_amount)
      @amount += new_amount if (@amount + new_amount) > BigDecimal("0")
    end
  end
end
