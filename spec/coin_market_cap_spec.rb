require 'ruby_crypto_etf'

module RubyCryptoETF
  describe CoinMarketCap do

    context "initialization" do
      let(:coin_market_cap) { CoinMarketCap.new }

      it "should create a new coin_market_cap object with default values" do
        expect(coin_market_cap.base_uri).to eq 'https://api.coinmarketcap.com'
        expect(coin_market_cap.conn).to_not be_nil
        expect(coin_market_cap.coin_tickers.empty?).to be true
        expect(coin_market_cap.capitalization).to eq ""
      end
    end

    it "should have a hash of endpoints" do
      expect(CoinMarketCap.endpoints.class.to_s).to eq 'Hash'
      expect(CoinMarketCap.endpoints.keys.any?).to be true
    end

    it "should have symbol mappings for assets" do
      expect(CoinMarketCap.symbol_mappings.class.to_s).to eq 'Hash'
      expect(CoinMarketCap.symbol_mappings.keys.any?).to be true
    end

    context "api fetching methods" do
      let(:coin_market_cap) { CoinMarketCap.new }
      let(:market_cap_uri) { coin_market_cap.base_uri + "#{CoinMarketCap.endpoints[:market_cap]}" }
      let(:ticker_uri) { coin_market_cap.base_uri + "#{CoinMarketCap.endpoints[:ticker]}" }
      let(:total_market_cap_response) { {
        total_market_cap_usd: 491165495017,
        total_24h_volume_usd: 24261266769,
        bitcoin_percentage_of_market_cap: 36.71,
        active_currencies: 902,
        active_assets: 611,
        active_markets: 8944,
        last_updated: 1518953067
      } }

      it "should fetch_total_market_cap" do
        stub = stub_request(:get, market_cap_uri)
          .to_return(body: total_market_cap_response.to_json)

        coin_market_cap.fetch_total_market_cap
        expect(coin_market_cap.capitalization).to eq total_market_cap_response[:total_market_cap_usd].to_s

        expect(stub).to have_been_requested
      end

      it "should fetch_tickers" do
      end
    end

    context "non api fetching methods" do
    end
  end
end
