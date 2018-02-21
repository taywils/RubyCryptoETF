require 'ruby_crypto_etf'

module RubyCryptoETF
  describe CsvDisplay do
    let (:dummy_display_data) { {
      "coins": nil
    } }

    it "should visualize display data as csv" do
      coin_double_a = double('coin', symbol: 'BTC', amount: BigDecimal("2.0"), exchange: 'coinbase', value: "22000.00")
      coin_double_b = double('coin', symbol: 'ETH', amount: BigDecimal("5.556"), exchange: 'binance', value: "8050.31")

      dummy_display_data[:coins] = [coin_double_a, coin_double_b]

      csv_display = CsvDisplay.new
      csv_string = csv_display.visualize(dummy_display_data)

      csv_string_rows = csv_string.split("\n")

      expect(csv_string_rows.length).to eq 3
      expect(csv_string_rows.first.split(',')).to eq csv_display.tabular_headings
    end
  end
end
