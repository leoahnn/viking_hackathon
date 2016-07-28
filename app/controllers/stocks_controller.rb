class StocksController < ApplicationController


  def create
    sym = params[:stock][:symbol]
    amount = params[:stock][:amount]
    @portfolio = Portfolio.find(params[:portfolio_id])
    stock_creator = StockCreator.new(sym, params[:portfolio_id], amount)
    if stock_creator.update_existing
      redirect_to portfolio_path(params[:portfolio_id])
    else
      sapi = StockApi.new(sym)
      if sapi.check_stock?
        @stock = Stock.new(merged_params(sapi.stock_params))
        @stock.portfolio_id = params[:portfolio_id]
        @stock.save ? flash[:success] = "#{@stock.name} added!" : flash[:alert] = "Stock not added!"
        redirect_to portfolio_path(params[:portfolio_id])
      else
        flash[:alert] = "Stock not found!"
        redirect_to edit_portfolio_path(params[:portfolio_id])
      end
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:portfolio_id])
    @stock = Stock.find(params[:id])
  end

  def update
    stock = Stock.find(params[:id])
    stock.update(amount: params[:stock][:amount])
    redirect_to portfolio_path(stock[:portfolio_id])
  end

  def destroy
    @stock = Stock.find(params[:id])
    if @stock.destroy
      flash[:success] = "'#{@stock.name}' Deleted!"
    else
      flash[:alert] = "stock not deleted!"
    end
    redirect_to portfolio_path(params[:portfolio_id])
  end

  private

  def merged_params(hash)
    hash.merge({amount: params[:stock][:amount]})
  end
  def white_listed
    params.require(:stock).permit(:id, :portfolio_id, :amount)
  end
end
