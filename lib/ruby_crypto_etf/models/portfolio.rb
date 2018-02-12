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
      display_data = {}
      display_data[:market_cap] = @market.capitalization
      display_data[:coins] = []

      @exchanges.each do |exchange|
        exchange.load_wallets
        display_data[:coins] += exchange.wallets
      end

      display_data
    end

    def load_from_settings(settings_file_path)
      settings = YAML.load_file(settings_file_path)

      accounts = settings['accounts'] if settings.keys.include?('accounts')

      if accounts.keys.include?('coinbase')
        coinbase_account = accounts['coinbase'].first
        integration_args = { api_key: coinbase_account['apiKey'],
                             api_secret: coinbase_account['apiSecret'] }
        coinbase_integration = CoinbaseIntegration.new(integration_args)
        self.add_exchange(coinbase_integration)
      end

      if accounts.keys.include?('binance')
        binance_account = accounts['binance'].first
        integration_args = { api_key: binance_account['apiKey'],
                             api_secret: binance_account['apiSecret'] }
        binance_integration = BinanceIntegration.new(integration_args)
        self.add_exchange(binance_integration)
      end
    end
  end
end
