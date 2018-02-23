require 'ruby_crypto_etf'

module RubyCryptoETF
  describe BinanceIntegration do
    context "initialization" do
      it "should use default values" do
        binance_integration = BinanceIntegration.new

        expect(binance_integration.client).to_not be_nil
        expect(binance_integration.client.class).to eq Binance::Api.clone.class
        expect(binance_integration.balances).to eq []
        expect(binance_integration.wallets).to eq []
        expect(binance_integration.name).to eq 'binance'
      end
    end

    context "api methods" do
      it "should fetch_balances" do
        client_double = double('client')
        allow(client_double).to receive(:info!) { {
          balances: [
            {:asset=>"BTC", :free=>"0.00022397", :locked=>"0.00000000"},
            {:asset=>"LTC", :free=>"0.00015271", :locked=>"0.00000000"},
            {:asset=>"ETH", :free=>"0.76477626", :locked=>"0.00000000"},
          ]
        } }

        initialization_args = {
          api_key: "",
          api_secret: "",
          client: client_double
        }
        binance_integration = BinanceIntegration.new initialization_args

        binance_integration.fetch_balances

        expect(binance_integration.balances.any?).to be true
        expect(binance_integration.balances.length).to be client_double.info![:balances].length
      end
    end

    context "non api methods" do
      it "should export an empty wallet when zero balances" do
        binance_integration = BinanceIntegration.new
        expect(binance_integration.export_wallets.empty?).to be true
      end

      it "should export a populated wallet" do
        client_double = double('client')
        allow(client_double).to receive(:info!) { {
          balances: [
            {:asset=>"BTC", :free=>"0.00022397", :locked=>"0.00000000"},
            {:asset=>"LTC", :free=>"0.00015271", :locked=>"0.00000000"},
            {:asset=>"ETH", :free=>"0.76477626", :locked=>"0.00000000"},
          ]
        } }

        initialization_args = {
          api_key: "",
          api_secret: "",
          client: client_double
        }
        binance_integration = BinanceIntegration.new initialization_args

        binance_integration.fetch_balances
        wallets = binance_integration.export_wallets
        
        expect(wallets.any?).to be true
        expect(wallets.length).to be client_double.info![:balances].length
        expect(wallets.first.class).to eq Coin
      end
    end
  end
end
