module RubyCryptoETF
  class CoinMarketCap
    attr_reader :base_uri
    attr_reader :conn
    attr_reader :coin_tickers
    attr_reader :capitalization

    def initialize(args = {})
      @base_uri = 'https://api.coinmarketcap.com'
      @conn = Faraday.new(url: @base_uri)
      @coin_tickers = []
      @capitalization = ""
    end

    def self.endpoints
      {
        market_cap: '/v1/global/',
        ticker: '/v1/ticker/'
      }
    end

    def self.symbol_mappings
      { 'BCC': 'BCH', 'IOTA': 'MIOTA' }
    end

    def fetch_total_market_cap
      response = @conn.get CoinMarketCap.endpoints[:market_cap]
      market_cap_response = JSON.parse(response.body)
      @capitalization = market_cap_response['total_market_cap_usd'].to_s
    end

    def fetch_tickers
      url = "#{CoinMarketCap.endpoints[:ticker]}/?limit=0"
      response = @conn.get url
      @coin_tickers = JSON.parse(response.body)
    end

    def fetch_ticker_for_name(coin_name)
      response = @conn.get "#{CoinMarketCap.endpoints[:ticker]}#{coin_name}/"
      fetched_ticker = JSON.parse(response.body)

      selected_indices = @coin_tickers.each_index.select do |index|
        @coin_tickers[index]['name'] = coin_name
      end

      @coin_tickers[selected_indices.first] = fetched_ticker
    end

    def get_usd_for_symbol(coin_symbol)
      if CoinMarketCap.symbol_mappings.key? coin_symbol.upcase.to_sym
        coin_symbol = CoinMarketCap.symbol_mappings[coin_symbol.to_sym]
      end

      coin_ticker = get_coin_ticker_for_symbol(coin_symbol)
      BigDecimal(coin_ticker['price_usd'])
    end

    def get_coin_ticker_for_symbol(symbol)
      @coin_tickers.find { |ticker| ticker['symbol'] == symbol.upcase }
    end
  end
end

