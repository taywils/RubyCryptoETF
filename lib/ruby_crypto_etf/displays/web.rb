module RubyCryptoETF
  class WebDisplay
    include BaseDisplay

    def visualize(display_data)
      coins_for_display = []
      display_data = display_data.tap do |data|
        data[:headings] = tabular_headings
        data[:market_cap] = display_usd_price(data[:market_cap]) || ''

        data[:coins].each do |coin|
          coin_hash = coin.to_h
          coin_hash[:amount] = display_bigdecimal(coin_hash[:amount])
          coin_hash[:value] = display_usd_price(coin_hash[:value])
          coins_for_display << coin_hash
        end
      end
      display_data[:coins] = coins_for_display
      display_data.to_json
    end
  end
end
