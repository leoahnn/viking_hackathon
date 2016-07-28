require 'rubygems'
require 'stock_quote'
class StockClient

def initialize(symbol)
  @stocks = StockQuote::Stock.quote(symbol)
end

end
