class StockRefresher
  class << self
    def refresh_all
      sapi = StockApi.new(all_symbols)
      sapi.multi_stock_params.each do |stock|
        current_stocks = Stock.where symbol: stock[:symbol]
        current_stocks.each { |s| s.update(stock) }
      end
    end


    def all_symbols
      symbols = []
      Stock.all.each do |stock|
        symbols << stock.symbol
      end
      symbols.uniq
    end
  end
  
end
