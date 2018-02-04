module RubyCryptoETF
  class CoinMarketCap
    attr_reader :base_uri
    attr_reader :conn
    attr_reader :coin_tickers
    attr_reader :market_cap

    def initialize(args = {})
      @base_uri = 'https://api.coinmarketcap.com'
      @conn = Faraday.new(url: @base_uri)
      @coin_tickers = []
      @market_cap = {}
    end

    def self.endpoints
      {
        market_cap: '/v1/global/',
        ticker: '/v1/ticker/'
      }
    end

    def fetch_total_market_cap
      response = @conn.get CoinMarketCap.endpoints[:market_cap]
      @market_cap = JSON.parse(response.body)
    end

    def fetch_tickers
      url = "#{CoinMarketCap.endpoints[:ticker]}/?limit=0"
      response = @conn.get url
      @coin_tickers = JSON.parse(response.body)
    end

    def fetch_ticker_for_name(coin_name)
      response = @conn.get "/v1/ticker/#{coin_name}/"
      ticker_for_coin_name = JSON.parse(response.body)
      #TODO Find the array index of the ticker with coin_name and update @coin_tickers
    end

    def get_usd_for_symbol(symbol)
      selected_coin_ticker = @coin_tickers.select do |coin_ticker|
        coin_ticker['symbol'] == symbol.upcase
      end
      pretty_usd_price BigDecimal(selected_coin_ticker['price_usd'])
    end

    private

    def pretty_usd_price(big_decimal_price)
      price_usd = BigDecimal(raw_string)
      price_split = price_usd.split
      price_significant_string = price_split[1]
      price_exponent = price_split[3]

      if price_exponent > 0
        dollars = price_significant_string.slice(0...price_exponent)
        slice_end = (price_significant_string.length - price_exponent - 2) * -1
        if slice_end == 0
          cents = price_significant_string.slice(price_exponent..-1)
        else
          cents = price_significant_string.slice(price_exponent...slice_end)
        end
        "$#{dollars}.#{cents}"
      elsif price_exponent == 0
        cents = price_significant_string.slice(0...2)
        "$0.#{cents}"
      elsif price_exponent == -1
        cent = price_significant_string.slice(0...1)
        "$0.0#{cent}"
      else
        "$0.00"
      end
    end
  end
end

