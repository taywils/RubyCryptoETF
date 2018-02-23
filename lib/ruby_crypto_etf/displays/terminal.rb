module RubyCryptoETF
  class TerminalDisplay
    include BaseDisplay

    attr_reader :table

    def initialize(args = {})
      @table = Terminal::Table.new.tap do |tbl|
        tbl.headings = tabular_headings
        tbl.title = 'Current MarketCap'
      end
    end

    def visualize(display_data)
      market_cap = display_usd_price(display_data[:market_cap]) || ''
      table_rows = []
      display_data[:coins].each do |coin|
        table_rows << [coin.symbol,
                       display_bigdecimal(coin.amount),
                       display_usd_price(coin.value),
                       coin.exchange]
      end

      @table.tap do |tbl|
        tbl.title += " #{market_cap}"
        tbl.rows = table_rows
      end
    end
  end
end
