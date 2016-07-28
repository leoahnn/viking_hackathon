class Portfolio < ActiveRecord::Base
  has_many :stocks

  def total_value
    value = 0
    self.stocks.all.each do |stock|
      value += stock.amount*stock.price
    end
    value.round(2)
  end

  

end
