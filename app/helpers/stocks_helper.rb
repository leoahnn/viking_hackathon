module StocksHelper

  def total_value(stock)
    (stock.price*stock.amount).round(2)
  end

end
