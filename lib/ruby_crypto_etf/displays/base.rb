module RubyCryptoETF
  module BaseDisplay
    def tabular_headings
      ['Asset', 'Amount', 'Value', 'Exchange']
    end

    def display_bigdecimal(big_decimal)
      if big_decimal.class != BigDecimal
        big_decimal = BigDecimal(big_decimal.to_s)
      end
      big_decimal.to_s("F")
    end

    def display_usd_price(price_string)
      Money.use_i18n = false

      price_usd = BigDecimal(price_string)
      price_split = price_usd.split
      price_significant_string = price_split[1]
      price_exponent = price_split[3]

      dollars_display = ->(dollars_string) do
        Monetize.parse(dollars_string).format.split('.').first
      end

      zero_dollars = dollars_display.call('0')

      if price_exponent > 0
        dollars = price_significant_string.slice(0...price_exponent)
        slice_end = (price_significant_string.length - price_exponent - 2) * -1
        if slice_end.zero?
          cents = price_significant_string.slice(price_exponent..-1)
        else
          cents = price_significant_string.slice(price_exponent...slice_end)
          cents = '00' if cents.empty?
        end
        "#{dollars_display.call(dollars)}.#{cents}"
      elsif price_exponent.zero?
        cents = price_significant_string.slice(0...2)
        if cents.to_i.zero?
          "#{zero_dollars}.00"
        else
          "#{zero_dollars}.#{cents}"
        end
      elsif price_exponent == -1
        cent = price_significant_string.slice(0...1)
        "#{zero_dollars}.0#{cent}"
      else
        "#{zero_dollars}.00"
      end
    end
  end
end
