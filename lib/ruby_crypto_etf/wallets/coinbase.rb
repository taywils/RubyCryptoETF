module RubyCryptoETF
  class Coinbase
    attr_writer :api_key
    attr_writer :api_secret
    attr_reader :client
    attr_reader :balances

    def initialize(args = {})
      @api_key = args[:api_key]
      @api_secret = args[:api_secret]
      @client = Coinbase::Wallet::Client.new(api_key: @api_key,
                                             api_secret: @api_secret)
      @balances = []
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
    end
  end
end
