module RubyCryptoETF
  class Portfolio
    attr_reader :exchanges

    def initialize(args = {})
      @exchanges = args[:exchanges] || []
    end

    def add_exchange(exchange)
      @exchanges << exchange
    end
  end
end
