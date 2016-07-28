require 'rubygems'
require 'stock_quote'
class StockApi
  attr_reader :stock
  def initialize(symbol)
    @stock = StockQuote::Stock.json_quote(symbol)
  end


  def stock_params
    s = @stock["quote"]
    {symbol: s["symbol"], name: s["Name"], price: s["Ask"], change: s["ChangeinPercent"].to_f, high: s["DaysHigh"], low: s["DaysLow"]}
  end

  def check_stock?
    @stock["quote"]["Name"]
  end

  def multi_stock_params
    all_stocks = []
    @stock["quote"].each do |s|
      all_stocks << {symbol: s["symbol"], name: s["Name"], price: s["Ask"], change: s["ChangeinPercent"].to_f, high: s["DaysHigh"], low: s["DaysLow"]}
    end
    all_stocks
  end
end
