module RubyCryptoETF
  class BinanceIntegration
    attr_writer :api_key
    attr_writer :api_secret
    attr_reader :client
    attr_reader :balances
    attr_reader :wallets
    attr_reader :name

    def initialize(args = {})
      @api_key = args[:api_key] || ""
      @api_secret = args[:api_secret] || ""

      Binance::Api::Configuration.api_key = @api_key
      Binance::Api::Configuration.secret_key = @api_secret

      @client = args[:client] || Binance::Api.clone
      @balances = args[:balances] ||  []
      @wallets = args[:wallets] || []
      @name = 'binance'
    end

    def fetch_balances
      binance_account_info = @client.info!
      binance_account_balances = binance_account_info[:balances]
      binance_account_balances.each do |balance|
        @balances << balance if BigDecimal(balance[:free]) > BigDecimal("0")
      end
    end

    def export_wallets
      if @balances.any?
        @wallets = []
        @balances.each do |balance|
          @wallets << Coin.new(symbol: balance[:asset], amount: balance[:free], exchange: @name)
        end
      end
      @wallets
    end
  end
end
