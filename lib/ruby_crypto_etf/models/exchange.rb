module RubyCryptoETF
  class Exchange
    attr_reader :name
    attr_reader :wallets

    def initialize(args = {})
      @wallets = args[:wallet] || nil
    end

    def name
      @wallets.name
    end

    def coin_symbols
      symbols = [] 
      @wallets.each do |coin|
        symbol << coin.symbol if !symbol.include?(coin.symbol)
      end
      return symbols
    end

    def amount_for_symbol(symbol)
      amount = BigDecimal("0")
      @wallets.each do |coin|

      end
      amount
    end
  end
end
