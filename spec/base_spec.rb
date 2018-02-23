require 'ruby_crypto_etf'

module RubyCryptoETF
  describe BaseDisplay do
    let(:dummy_display) { Class.new { extend BaseDisplay } }

    it "should have a method named tabular_headings" do
      expect(BaseDisplay.method_defined? :tabular_headings).to be true
      expect(dummy_display.respond_to? :tabular_headings).to be true
    end

    it "tabular_headings should return an array" do
      expect(dummy_display.tabular_headings.class.to_s).to eq('Array')
      expect(dummy_display.tabular_headings.any?).to be true
    end

    it "should have a method named display_bigdecimal" do
      expect(BaseDisplay.method_defined? :display_bigdecimal).to eq(true)
      expect(dummy_display.respond_to? :display_bigdecimal).to eq(true)
    end

    it "display_bigdecimal should pretty print BigDecimal strings" do
      raw_number_string = "12345.678"
      big_decimal_raw_number_string = BigDecimal(raw_number_string).to_s
      expect(big_decimal_raw_number_string).to eq("0.12345678e5")
      expect(dummy_display.display_bigdecimal(big_decimal_raw_number_string)).to eq(raw_number_string)
    end

    it "should have a method named display_usd_price" do
      expect(BaseDisplay.method_defined? :display_usd_price).to be true
      expect(dummy_display.respond_to? :display_usd_price).to be true
    end

    it "should display_usd_price correctly" do
      price_inputs = %w[
        9177.44
        0.928308
        0.000345882
        0
        12.0
        54.00
        456789001314.569999
        10.0
        7
        22000.00
      ]
      price_outputs = %w[
        $9,177.44
        $0.92
        $0.00
        $0.00
        $12.00
        $54.00
        $456,789,001,314.56
        $10.00
        $7.00
        $22,000.00
      ]

      expect(price_inputs.length).to eq price_outputs.length

      0.upto(price_inputs.length - 1) do |index|
        expect(dummy_display.display_usd_price(price_inputs[index])).to eq price_outputs[index]
      end

      expect(dummy_display.display_usd_price(nil)).to eq "$0.00"
    end
  end
end
