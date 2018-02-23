require 'ruby_crypto_etf'

module RubyCryptoETF
  describe TerminalDisplay do
    let (:dummy_display_data) { {
      "coins": nil
    } }

    it "should visualize display data as a terminal table" do
      coin_double_a = double('coin', symbol: 'BTC', amount: BigDecimal("2.0"), exchange: 'coinbase', value: "22000.00")
      coin_double_b = double('coin', symbol: 'ETH', amount: BigDecimal("5.556"), exchange: 'binance', value: "8050.31")

      dummy_display_data[:coins] = [coin_double_a, coin_double_b]
      dummy_display_data[:market_cap] = "123456.789"

      terminal_diplay = TerminalDisplay.new
      table = terminal_diplay.visualize dummy_display_data

      expect(table.rows.length).to eq dummy_display_data[:coins].length
      expect(table.title).to eq "Current MarketCap $123,456.78"
    end
  end
end
