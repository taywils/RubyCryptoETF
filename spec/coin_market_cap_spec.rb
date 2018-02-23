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

    context "static methods" do
      it "should have a hash of endpoints" do
        expect(CoinMarketCap.endpoints.class.to_s).to eq 'Hash'
        expect(CoinMarketCap.endpoints.keys.any?).to be true
      end

      it "should have symbol mappings for assets" do
        expect(CoinMarketCap.symbol_mappings.class.to_s).to eq 'Hash'
        expect(CoinMarketCap.symbol_mappings.keys.any?).to be true
      end
    end

    context "api fetching methods" do
      let(:coin_market_cap) { CoinMarketCap.new }

      let(:market_cap_uri) { coin_market_cap.base_uri + "#{CoinMarketCap.endpoints[:market_cap]}" }
      let(:total_market_cap_response) { {
        total_market_cap_usd: 491165495017,
        total_24h_volume_usd: 24261266769,
        bitcoin_percentage_of_market_cap: 36.71,
        active_currencies: 902,
        active_assets: 611,
        active_markets: 8944,
        last_updated: 1518953067
      } }

      let(:tickers_uri) { coin_market_cap.base_uri + "#{CoinMarketCap.endpoints[:ticker]}?limit=0" }
      let(:tickers_response) {
        [
          {
            "id": "bitcoin", 
            "name": "Bitcoin", 
            "symbol": "BTC", 
            "rank": "1", 
            "price_usd": "10677.7", 
            "price_btc": "1.0", 
            "24h_volume_usd": "8680670000.0", 
            "market_cap_usd": "180165899870", 
            "available_supply": "16873100.0", 
            "total_supply": "16873100.0", 
            "max_supply": "21000000.0", 
            "percent_change_1h": "1.23", 
            "percent_change_24h": "-4.91", 
            "percent_change_7d": "27.2", 
            "last_updated": "1519003769"
          }, 
          {
            "id": "ethereum", 
            "name": "Ethereum", 
            "symbol": "ETH", 
            "rank": "2", 
            "price_usd": "935.37", 
            "price_btc": "0.0887748", 
            "24h_volume_usd": "2560960000.0", 
            "market_cap_usd": "91387395452.0", 
            "available_supply": "97701867.0", 
            "total_supply": "97701867.0", 
            "max_supply": nil, 
            "percent_change_1h": "1.21", 
            "percent_change_24h": "-4.29", 
            "percent_change_7d": "11.47", 
            "last_updated": "1519003752"
          }, 
          {
            "id": "ripple", 
            "name": "Ripple", 
            "symbol": "XRP", 
            "rank": "3", 
            "price_usd": "1.14192", 
            "price_btc": "0.00010838", 
            "24h_volume_usd": "1116770000.0", 
            "market_cap_usd": "44545403750.0", 
            "available_supply": "39009215838.0", 
            "total_supply": "99992725510.0", 
            "max_supply": "100000000000", 
            "percent_change_1h": "1.33", 
            "percent_change_24h": "-4.96", 
            "percent_change_7d": "8.97", 
            "last_updated": "1519003741"
          }
        ]
      }

      let(:ticker_for_name_uri) { coin_market_cap.base_uri + "#{CoinMarketCap.endpoints[:ticker]}bitcoin/" }
      let(:ticker_for_name_response) {
        [
          {
            "id": "bitcoin", 
            "name": "Bitcoin", 
            "symbol": "BTC", 
            "rank": "1", 
            "price_usd": "10714.8", 
            "price_btc": "1.0", 
            "24h_volume_usd": "8635240000.0", 
            "market_cap_usd": "180792427620", 
            "available_supply": "16873150.0", 
            "total_supply": "16873150.0", 
            "max_supply": "21000000.0", 
            "percent_change_1h": "1.47", 
            "percent_change_24h": "-4.63", 
            "percent_change_7d": "27.62", 
            "last_updated": "1519004666"
          }
        ]
      }

      it "should fetch_total_market_cap" do
        stub = stub_request(:get, market_cap_uri)
          .to_return(body: total_market_cap_response.to_json)

        coin_market_cap.fetch_total_market_cap
        expect(coin_market_cap.capitalization).to eq total_market_cap_response[:total_market_cap_usd].to_s

        expect(stub).to have_been_requested
      end

      it "should fetch_tickers" do
        stub = stub_request(:get, tickers_uri)
          .to_return(body: tickers_response.to_json)

        coin_market_cap.fetch_tickers

        expect(coin_market_cap.coin_tickers.length).to eq tickers_response.length

        response_ticker_names = tickers_response.map { |ticker| ticker[:name] }
        expect(coin_market_cap.coin_tickers.map { |ticker| ticker[:name] }).to eq response_ticker_names

        expect(stub).to have_been_requested
      end

      it "should fetch_ticker_for_name" do
        stub = stub_request(:get, ticker_for_name_uri)
          .to_return(body: ticker_for_name_response.to_json)

        ticker = coin_market_cap.fetch_ticker_for_name('bitcoin')

        expect(ticker).to eq ticker_for_name_response.first

        expect(stub).to have_been_requested
      end
    end

    context "non api fetching methods" do
      let(:dummy_coin_tickers) {
        [
          {
            "id": "bitcoin", 
            "name": "Bitcoin", 
            "symbol": "BTC", 
            "rank": "1", 
            "price_usd": "10677.7", 
            "price_btc": "1.0", 
            "24h_volume_usd": "8680670000.0", 
            "market_cap_usd": "180165899870", 
            "available_supply": "16873100.0", 
            "total_supply": "16873100.0", 
            "max_supply": "21000000.0", 
            "percent_change_1h": "1.23", 
            "percent_change_24h": "-4.91", 
            "percent_change_7d": "27.2", 
            "last_updated": "1519003769"
          }
        ]
      }
      let(:coin_market_cap) { CoinMarketCap.new({ coin_tickers: dummy_coin_tickers }) }

      it "should get_coin_ticker_for_symbol" do
        btccccc_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btccccc'
        expect(btccccc_ticker).to be_nil

        bitcoin_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btc'
        expect(bitcoin_ticker).to eq dummy_coin_tickers.first
      end

      it "should get_usd_for_symbol" do
        expect(coin_market_cap.get_usd_for_symbol('zzzzzzz')).to be_nil
        expect(coin_market_cap.get_usd_for_symbol('btc')).to eq BigDecimal(dummy_coin_tickers.first[:price_usd])
      end

      it "should update_ticker_for_symbol with new price" do
        bitcoin_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btc'
        bitcoin_ticker[:price_usd] = BigDecimal("2000")

        coin_market_cap.update_ticker_for_symbol('btc', bitcoin_ticker)
        updated_bitcoin_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btc'

        expect(updated_bitcoin_ticker).to eq bitcoin_ticker
      end

      it "should not update_ticker_for_symbol if symbol is not found" do
        bitcoin_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btc'
        bitcoin_ticker[:price_usd] = BigDecimal("2000")

        coin_market_cap.update_ticker_for_symbol('btccccccc', bitcoin_ticker)
        updated_bitcoin_ticker = coin_market_cap.get_coin_ticker_for_symbol 'btc'

        expect(updated_bitcoin_ticker[:price_usd]).to eq dummy_coin_tickers.first[:price_usd]
      end
    end
  end
end
