module RubyCryptoETF
  class CsvDisplay
    include BaseDisplay

    def visualize(display_data)
      csv_string = CSV.generate do |csv|
        csv << tabular_headings

        display_data[:coins].each do |coin|
          csv << [coin.symbol,
                  display_bigdecimal(coin.amount),
                  display_usd_price(coin.value),
                  coin.exchange]
        end
      end
      csv_string
    end
  end
end
