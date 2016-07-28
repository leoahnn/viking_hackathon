class StockCreator

  def initialize(stock, portfolio_id, amount)
    @stock = stock.upcase
    @amount = amount.to_i
    @portfolio_id = portfolio_id
  end

  def update_existing
    if stock = existing_stock
      total = stock.amount.to_i + @amount
      stock.update(amount: total)
      return true
    end
    false
  end

  def existing_stock
    p = Portfolio.find(@portfolio_id)
    p.stocks.find_by symbol: @stock
  end
end
