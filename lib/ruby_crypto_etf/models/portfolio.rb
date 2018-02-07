module RubyCryptoETF
  class Portfolio
    attr_reader :exchanges
    attr_reader :market
    attr_accessor :display

    def initialize(args = {})
      @exchanges = args[:exchanges] || []
      @display = args[:display] || nil
      @market = args[:market] || nil
    end

    def add_exchange(exchange)
      @exchanges << exchange
    end

    def visualize
      display_data = prepare_for_visualization
      @display.visualize(display_data)
    end

    def prepare_for_visualization

    end
  end
end
