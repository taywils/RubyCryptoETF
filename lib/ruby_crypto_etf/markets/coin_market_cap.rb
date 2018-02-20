module RubyCryptoETF
  class CoinMarketCap
    attr_reader :base_uri
    attr_reader :conn
    attr_reader :coin_tickers
    attr_reader :capitalization

    def initialize(args = {})
      @base_uri = args[:base_uri] || 'https://api.coinmarketcap.com'
      @conn = args[:conn] || Faraday.new(url: @base_uri)
      @coin_tickers = args[:coin_tickers] || []
      @capitalization = args[:capitalization] || ""
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
      if response.success?
        market_cap_response = JSON.parse(response.body, symbolize_names: true)
        @capitalization = market_cap_response[:total_market_cap_usd].to_s
      end
    end

    def fetch_tickers
      url = "#{CoinMarketCap.endpoints[:ticker]}/?limit=0"
      response = @conn.get url
      if response.success?
        @coin_tickers = JSON.parse(response.body, symbolize_names: true)
      end
    end

    def fetch_ticker_for_name(coin_name)
      response = @conn.get "#{CoinMarketCap.endpoints[:ticker]}#{coin_name}/"
      if response.success?
        JSON.parse(response.body, symbolize_names: true).first
      else
        nil
      end
    end

    def get_coin_ticker_for_symbol(symbol)
      @coin_tickers.find { |ticker| ticker[:symbol] == symbol.upcase }
    end

    def get_usd_for_symbol(coin_symbol)
      if CoinMarketCap.symbol_mappings.key? coin_symbol.upcase.to_sym
        coin_symbol = CoinMarketCap.symbol_mappings[coin_symbol.to_sym]
      end

      coin_ticker = get_coin_ticker_for_symbol(coin_symbol)
      if coin_ticker.nil?
        nil
      else
        BigDecimal(coin_ticker[:price_usd])
      end
    end

    def update_ticker_for_symbol(ticker_symbol, new_ticker)
      selected_ticker_indices = @coin_tickers.each_index.select do |index|
        @coin_tickers[index][:symbol] == ticker_symbol.upcase
      end

      if selected_ticker_indices.any?
        @coin_tickers[selected_ticker_indices.first] = new_ticker 
      end
    end
  end
end

