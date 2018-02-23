require 'ruby_crypto_etf'

module RubyCryptoETF
  describe WebDisplay do
    let (:dummy_display_data) { {
      "coins": nil
    } }

    it "should visualize web data as JSON" do
      coin_double_a = double('coin', symbol: 'BTC', amount: BigDecimal("2.0"), exchange: 'coinbase', value: "22000.00")
      coin_double_b = double('coin', symbol: 'ETH', amount: BigDecimal("5.556"), exchange: 'binance', value: "8050.31")

      allow(coin_double_a).to receive(:to_h) { {
        symbol: coin_double_a.symbol,
        amount: coin_double_a.amount,
        exchange: coin_double_a.exchange,
        value: coin_double_a.value
      } }

      allow(coin_double_b).to receive(:to_h) { {
        symbol: coin_double_b.symbol,
        amount: coin_double_b.amount,
        exchange: coin_double_b.exchange,
        value: coin_double_b.value
      } }

      dummy_display_data[:coins] = [coin_double_a, coin_double_b]
      dummy_display_data[:market_cap] = "123456.789"

      web_display = WebDisplay.new
      json_for_web_string = web_display.visualize dummy_display_data
      parsed_json_from_web_string = JSON.parse(json_for_web_string)

      expect(parsed_json_from_web_string.class).to eq Hash
      expect(parsed_json_from_web_string.keys).to eq ['coins', 'market_cap', 'headings']
    end
  end
end
