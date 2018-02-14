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
      { 'BCC': 'BCH' }
    end

    def fetch_total_market_cap
      response = @conn.get CoinMarketCap.endpoints[:market_cap]
      market_cap_response = JSON.parse(response.body)
      total_market_cap_usd_string = market_cap_response['total_market_cap_usd'].to_s
      @capitalization = display_usd_price(total_market_cap_usd_string)
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
      if CoinMarketCap.symbol_mappings.key? coin_symbol.to_sym
        coin_symbol = CoinMarketCap.symbol_mappings[coin_symbol.to_sym]
      end

      coin_ticker = get_coin_ticker_for_symbol(coin_symbol)
      byebug
      BigDecimal(coin_ticker['price_usd'])
    end

    def get_coin_ticker_for_symbol(symbol)
      @coin_tickers.find { |ticker| ticker['symbol'] == symbol.upcase }
    end

    private

    def display_usd_price(total_market_cap_usd_string)
      Money.use_i18n = false

      price_usd = BigDecimal(total_market_cap_usd_string)
      price_split = price_usd.split
      price_significant_string = price_split[1]
      price_exponent = price_split[3]

      dollars_display = ->(dollars_string) do
        Monetize.parse(dollars_string).format.split('.').first
      end

      zero_dollars = dollars_display.call('0')

      if price_exponent > 0
        dollars = price_significant_string.slice(0...price_exponent)
        slice_end = (price_significant_string.length - price_exponent - 2) * -1
        if slice_end.zero?
          cents = price_significant_string.slice(price_exponent..-1)
        else
          cents = price_significant_string.slice(price_exponent...slice_end)
          cents = '00' if cents.empty?
        end
        "#{dollars_display.call(dollars)}.#{cents}"
      elsif price_exponent.zero?
        cents = price_significant_string.slice(0...2)
        if cents.to_i.zero?
          "#{zero_dollars}.00"
        else
          "#{zero_dollars}.#{cents}"
        end
      elsif price_exponent == -1
        cent = price_significant_string.slice(0...1)
        "#{zero_dollars}.0#{cent}"
      else
        "#{zero_dollars}.00"
      end
    end
  end
end

