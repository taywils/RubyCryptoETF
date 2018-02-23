require 'ruby_crypto_etf'

module RubyCryptoETF
  describe Exchange do

    context "initialization" do
      it "should create a new Exchange" do
        exchange = Exchange.new

        expect(exchange.name).to eq ""
        expect(exchange.integration).to be_nil
        expect(exchange.wallets.empty?).to be true

        integration_double = double('integration', name: 'Binance')

        exchange = Exchange.new({ integration: integration_double })
        expect(exchange.name).to eq 'Binance'
        expect(exchange.integration).to_not be_nil
      end
    end

    context "methods" do
      it "should load_wallets" do
        integration_double = double('integration', name: 'Binance')
        allow(integration_double).to receive(:fetch_balances) { nil }

        coin_double = double('coin')
        allow(integration_double).to receive(:export_wallets) { [coin_double] }

        exchange = Exchange.new({ integration: integration_double })

        exchange.load_wallets

        expect(exchange.wallets).to_not be_nil
        expect(exchange.wallets.any?).to be true
      end
    end
  end
end
