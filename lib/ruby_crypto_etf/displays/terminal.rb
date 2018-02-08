module RubyCryptoETF
  attr_reader :table

  class Terminal
    def initialize(args = {})
      table = Terminal::Table.new
      table.headings = ['Coin', 'Amount', 'Value Est.', 'Exchanges']
      table.title = 'Current MarketCap'
      @table = table
    end

    def visualize(display_data)
      market_cap = display_data[:market_cap] || ''
      table.title += " #{market_cap}"
      table_rows = []
      display_data[:coins].each do |coin|
        table_rows << [coin.symbol, coin.amount, coin.exchange]
      end
      @table.rows = table_rows
      @table
    end
  end
end
