module RubyCryptoETF
  class CoinMarketCap
    attr_reader :base_uri
    attr_reader :conn
    attr_reader :coin_stats

    def initialize(args = {})
      @base_uri = 'https://api.coinmarketcap.com'
      @conn = Faraday.new(url: @base_uri)
      @coin_stats = []
    end

    def get_total_market_cap
    end

    def fetch_coin_stats
      response = @conn.get '/v1/ticker/?limit=0'
      @coin_stats = JSON.parse(response.body)
    end

    def get_usd_for_symbol(symbol)
      selected_coin_stat = @coin_stats.select do |coin_stat|
        coin_stat['symbol'] == symbol.upcase
      end
      BigDecimal(selected_coin_stat['price_usd'])
    end
  end
end

