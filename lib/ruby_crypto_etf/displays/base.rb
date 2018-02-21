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

    def display_usd_price(floating_point_string, currency_code = 'USD')
      Money.use_i18n = false

      if floating_point_string.count('.') > 0
        integer, fraction = floating_point_string.split '.'
      else
        integer = floating_point_string
        fraction = '0'
      end

      if fraction.length == 1
        fraction += '0'
      else
        fraction = fraction.slice(0..1)
      end

      monetized_integer = Monetize.parse(currency_code.upcase + integer)
      integer = monetized_integer.format.split(monetized_integer.separator).first

      integer + monetized_integer.separator + fraction
    end
  end
end
