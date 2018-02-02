require 'spec_helper'
require 'ruby_crypto_etf'

module RubyCryptoETF
  describe Coin do
    it "creates a new coin with symbol and amount" do
      coin = Coin.new(symbol: 'btc', amount: BigDecimal("0.001"))

      expect(coin.symbol).to_not be_nil
      expect(coin.amount).to_not be_nil

      expect(coin.symbol).to eq('BTC')
      expect(coin.amount).to eq(BigDecimal("0.001"))
    end

    it "sets default values for initializer" do
      coin = Coin.new

      expect(coin.symbol).to eq("")
      expect(coin.amount).to eq(BigDecimal("0"))
    end

    it "will always convert a numeric amount to BigDecimal" do
      coin_amount_float = 1.2345
      coin = Coin.new(amount: coin_amount_float)

      expect(coin.amount.class).to eq(BigDecimal)
      expect(coin.amount).to eq(BigDecimal(coin_amount_float.to_s))
    end

    it "will always add_amount as a positive BigDecimal" do
      coin = Coin.new(symbol: 'ETH', amount: 1.23)

      coin.add_amount 0.004
      expect(coin.amount).to eq(BigDecimal("1.234"))

      coin.add_amount 2.00000
      expect(coin.amount).to eq(BigDecimal("3.234"))

      coin.add_amount(-4.0)
      expect(coin.amount).to eq(BigDecimal("3.234"))

      coin.add_amount(-3.0)
      expect(coin.amount).to eq(BigDecimal("0.234"))
    end

    it "will set a new Coin initialized with negative amount to zero" do
      coin = Coin.new(symbol: 'XVG', amount: -10.234555)

      expect(coin.amount).to eq(BigDecimal("0"))
    end
  end
end
