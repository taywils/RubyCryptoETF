require 'ruby_crypto_etf'

module RubyCryptoETF
  describe CoinbaseIntegration do
    context "initialization" do
      it "should use default values" do
        coinbase_integration = CoinbaseIntegration.new

        expect(coinbase_integration.client).to_not be_nil
        expect(coinbase_integration.client.class).to eq Coinbase::Wallet::Client
        expect(coinbase_integration.balances).to eq []
        expect(coinbase_integration.wallets).to eq []
        expect(coinbase_integration.name).to eq 'coinbase'
      end
    end

    context "api methods" do
      it "should fetch non-empty balances" do
        client_double = double('client')
        allow(client_double).to receive(:accounts) { 
          [
            {"id"=>"16fad6af-e1c7-54f3-b15f", "name"=>"BCH Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"BCH", "balance"=>{"amount"=>"0.00000000", "currency"=>"BCH"}, "created_at"=>"2017-12-14T04:24:23Z", "updated_at"=>"2017-12-15T11:42:59Z", "resource"=>"account", "resource_path"=>"/v2/accounts/16fad6af-e1c7-54f3-b15f", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"7eb46099-870d-544e-bde7", "name"=>"USD Wallet", "primary"=>false, "type"=>"fiat", "currency"=>"USD", "balance"=>{"amount"=>"0.00", "currency"=>"USD"}, "created_at"=>"2017-05-31T07:35:01Z", "updated_at"=>"2017-09-11T21:09:57Z", "resource"=>"account", "resource_path"=>"/v2/accounts/7eb46099-870d-544e-bde7", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"7f1b1885-796e-5bb6-8b29", "name"=>"LTC Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"LTC", "balance"=>{"amount"=>"0.00000000", "currency"=>"LTC"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2017-12-29T23:45:04Z", "resource"=>"account", "resource_path"=>"/v2/accounts/7f1b1885-796e-5bb6-8b29", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"543756ee-5ab6-5d7e-9ccb", "name"=>"ETH Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"ETH", "balance"=>{"amount"=>"0.00000000", "currency"=>"ETH"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2018-01-20T04:50:35Z", "resource"=>"account", "resource_path"=>"/v2/accounts/543756ee-5ab6-5d7e-9ccb", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"d273ab31-354b-5adc-9a14", "name"=>"BTC Wallet", "primary"=>true, "type"=>"wallet", "currency"=>"BTC", "balance"=>{"amount"=>"0.00000001", "currency"=>"BTC"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2018-01-12T07:16:13Z", "resource"=>"account", "resource_path"=>"/v2/accounts/d273ab31-354b-5adc-9a14", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}}
          ]
        }

        initialization_args = {
          api_key: "",
          api_secret: "",
          client: client_double
        }
        coinbase_integration = CoinbaseIntegration.new initialization_args

        coinbase_integration.fetch_balances

        expect(coinbase_integration.balances.any?).to be true
        expect(coinbase_integration.balances.length).to be 1
      end
    end

    context "non api methods" do
      it "should export an empty wallet when zero balances" do
        coinbase_integration = CoinbaseIntegration.new
        expect(coinbase_integration.export_wallets.empty?).to be true
      end

      it "should export a populated wallet" do
        client_double = double('client')
        allow(client_double).to receive(:accounts) { 
          [
            {"id"=>"16fad6af-e1c7-54f3-b15f", "name"=>"BCH Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"BCH", "balance"=>{"amount"=>"0.00000000", "currency"=>"BCH"}, "created_at"=>"2017-12-14T04:24:23Z", "updated_at"=>"2017-12-15T11:42:59Z", "resource"=>"account", "resource_path"=>"/v2/accounts/16fad6af-e1c7-54f3-b15f", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"7eb46099-870d-544e-bde7", "name"=>"USD Wallet", "primary"=>false, "type"=>"fiat", "currency"=>"USD", "balance"=>{"amount"=>"0.00", "currency"=>"USD"}, "created_at"=>"2017-05-31T07:35:01Z", "updated_at"=>"2017-09-11T21:09:57Z", "resource"=>"account", "resource_path"=>"/v2/accounts/7eb46099-870d-544e-bde7", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"7f1b1885-796e-5bb6-8b29", "name"=>"LTC Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"LTC", "balance"=>{"amount"=>"0.00000000", "currency"=>"LTC"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2017-12-29T23:45:04Z", "resource"=>"account", "resource_path"=>"/v2/accounts/7f1b1885-796e-5bb6-8b29", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"543756ee-5ab6-5d7e-9ccb", "name"=>"ETH Wallet", "primary"=>false, "type"=>"wallet", "currency"=>"ETH", "balance"=>{"amount"=>"0.00000000", "currency"=>"ETH"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2018-01-20T04:50:35Z", "resource"=>"account", "resource_path"=>"/v2/accounts/543756ee-5ab6-5d7e-9ccb", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}},
            {"id"=>"d273ab31-354b-5adc-9a14", "name"=>"BTC Wallet", "primary"=>true, "type"=>"wallet", "currency"=>"BTC", "balance"=>{"amount"=>"0.00000001", "currency"=>"BTC"}, "created_at"=>"2017-05-31T04:30:03Z", "updated_at"=>"2018-01-12T07:16:13Z", "resource"=>"account", "resource_path"=>"/v2/accounts/d273ab31-354b-5adc-9a14", "native_balance"=>{"amount"=>"0.00", "currency"=>"USD"}}
          ]
        }

        initialization_args = {
          api_key: "",
          api_secret: "",
          client: client_double
        }
        coinbase_integration = CoinbaseIntegration.new initialization_args

        coinbase_integration.fetch_balances
        wallets = coinbase_integration.export_wallets

        expect(wallets.any?).to be true
        expect(wallets.length).to be 1
        expect(wallets.first.class).to eq Coin
      end
    end
  end
end
