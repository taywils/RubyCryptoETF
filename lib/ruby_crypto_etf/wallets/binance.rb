module RubyCryptoETF
  class Binance
    attr_writer :api_key
    attr_writer :api_secret
    attr_reader :client
    attr_reader :balances

    def initialize(args = {})
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]

      Binance::Api::Configuration.api_key = @api_key
      Binance::Api::Configuration.secret_key = @api_secret

      @client = Binance::Api.clone
      @balances = []
    end

    def fetch_balances
      @balances = @client.info!
    end
  end
end
