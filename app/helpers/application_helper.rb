module ApplicationHelper

  def all_portfolio_value
    total = 0
    Portfolio.all.each { |folio| total += folio.total_value }
    total.round(2)
  end

end
