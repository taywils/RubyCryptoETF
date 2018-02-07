module RubyCryptoETF
  class Exchange
    attr_reader :name
    attr_reader :integration
    attr_reader :wallets

    def initialize(args = {})
      @integration = args[:integration] || nil
      @name = @integration.name
    end

    def load_wallets
      @integration.fetch_balances
      @wallets = @integration.export_wallets
    end
  end
end
