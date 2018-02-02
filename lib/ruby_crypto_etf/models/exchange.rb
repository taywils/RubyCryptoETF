module RubyCryptoETF
  class Exchange
    attr_reader :name
    attr_reader :wallets

    def initialize(args = {})
      @wallets = []
    end

    def add_wallet(wallet)
      @wallets << wallet
    end
  end
end
