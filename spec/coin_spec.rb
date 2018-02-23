require 'ruby_crypto_etf'

module RubyCryptoETF
  describe Coin do
    context "initialization" do
      it "should create a new Coin" do
        coin = Coin.new(symbol: 'btc',
                        amount: BigDecimal("0.001"),
                        exchange: 'BiNaNcE',
                        value: BigDecimal("8856.01"))

        expect(coin.symbol).to_not be_nil
        expect(coin.amount).to_not be_nil
        expect(coin.exchange).to_not be_nil
        expect(coin.value).to_not be_nil

        expect(coin.symbol).to eq('BTC')
        expect(coin.amount).to eq(BigDecimal("0.001"))
        expect(coin.exchange).to eq('binance')
        expect(coin.value).to eq(BigDecimal("8856.01"))
      end
    end

    it "sets default values for initializer" do
      coin = Coin.new

      expect(coin.symbol).to eq("")
      expect(coin.exchange).to eq("")
      expect(coin.amount).to eq(BigDecimal("0"))
      expect(coin.value).to eq(BigDecimal("0"))
    end

    it "will always convert a numeric amount to BigDecimal" do
      coin_amount_float = 1.2345
      coin_value_float = 89714.144
      coin = Coin.new(amount: coin_amount_float, value: coin_value_float)

      expect(coin.amount.class).to eq(BigDecimal)
      expect(coin.amount).to eq(BigDecimal(coin_amount_float.to_s))

      expect(coin.value.class).to eq(BigDecimal)
      expect(coin.value).to eq(BigDecimal(coin_value_float.to_s))
    end

    it "will always add amount as a positive BigDecimal" do
      coin = Coin.new(symbol: 'ETH', amount: 1.23)

      coin.amount += 0.004
      expect(coin.amount).to eq(BigDecimal("1.234"))

      coin.amount += 2.00000
      expect(coin.amount).to eq(BigDecimal("3.234"))

      coin.amount += -4.0
      expect(coin.amount).to eq(BigDecimal("3.234"))

      coin.amount += -3.0
      expect(coin.amount).to eq(BigDecimal("0.234"))

      coin.amount += -3.0
      expect(coin.amount).to eq(BigDecimal("0.234"))

      coin.amount = coin.amount + 1
      expect(coin.amount).to eq(BigDecimal("1.234"))
    end

    it "will set a new Coin initialized with negative amount to zero" do
      coin = Coin.new(symbol: 'XVG', amount: -10.234555, exchange: 'Binance',
                     value: -13151)

      expect(coin.amount).to eq(BigDecimal("0"))
      expect(coin.value).to eq(BigDecimal("0"))
    end

    it "will only set new positive values" do
      coin = Coin.new()

      coin_value = BigDecimal("100")
      coin.value = coin_value

      expect(coin.value).to eq(coin_value)

      coin.value = -1.23145
      expect(coin.value).to eq(coin_value)

      coin.value = 200
      expect(coin.value).to_not eq(coin_value)
      expect(coin.value).to eq(BigDecimal("200"))

      coin.value *= -1
      expect(coin.value).to eq(BigDecimal("200"))

      coin.value *= 10
      expect(coin.value).to eq(BigDecimal("2000"))
    end

    it "should be serialized to a hash" do
      coin = Coin.new(symbol: 'ETH', amount: 1.23, exchange: 'gemini', value: 246)

      coin_hash = { symbol: 'ETH', amount: BigDecimal("1.23"), exchange: 'gemini', value: BigDecimal("246") }

      expect(coin.to_h).to eq(coin_hash)
    end
  end
end
