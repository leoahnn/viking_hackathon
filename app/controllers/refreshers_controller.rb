class RefreshersController < ApplicationController

  def update
    StockRefresher.refresh_all
    redirect_to portfolios_path
  end

end
