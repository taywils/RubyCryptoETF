module RubyCryptoETF
  attr_reader :table

  class Terminal
    def initialize(args = {})
      table = Terminal::Table.new
      table.headings = ['Coin', 'Amount', 'Value USD', 'Exchanges']
      @table = table
    end

    def visualize(display_data)

    end
  end
end
