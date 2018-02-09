module RubyCryptoETF
  class CoinbaseIntegration
    attr_writer :api_key
    attr_writer :api_secret
    attr_reader :client
    attr_reader :balances
    attr_reader :wallets
    attr_reader :name

    def initialize(args = {})
      @api_key = args[:api_key] || ""
      @api_secret = args[:api_secret] || ""
      @client = Coinbase::Wallet::Client.new(api_key: @api_key,
                                             api_secret: @api_secret)
      @balances = []
      @wallets = []
      @name = 'coinbase'
    end

    def fetch_balances
      fetch_balances_response = client.accounts

      fetch_balances_response.each do |account|
        account_includes_wallet = account.key?('type') && account['type'] == 'wallet'
        account_has_balance = account.key?('balance') && account['balance'].key?('amount')

        if account_includes_wallet && account_has_balance
          @balances << account['balance'] if BigDecimal(account['balance']['amount']) > BigDecimal("0")
        end
      end
      @balances
    end

    def export_wallets
      if @balances.any?
        @wallets = []
        @balances.each do |balance|
          @wallets << Coin.new(symbol: balance["currency"], amount: balance["amount"], exchange: @name)
        end
      end
      @wallets
    end
  end
end
