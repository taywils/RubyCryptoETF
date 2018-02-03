module RubyCryptoETF
  class Exchange
    attr_reader :name
    attr_reader :wallet

    def initialize(args = {})
      @wallets = nil
    end

    def add_wallet(wallet)
      @wallet << wallet
    end
  end
end
