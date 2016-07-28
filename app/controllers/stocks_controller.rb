class StocksController < ApplicationController


  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    get_stock = stock_api(params[:stock][:symbol])
    if check_stock(get_stock)
      @stock = Stock.new(stock_params(get_stock))
      @stock.portfolio_id = params[:portfolio_id]
      if @stock.save
        flash[:success] = "#{@stock.name} added!"
        redirect_to portfolio_path(@stock.portfolio_id)
      else
        flash.now[:alert] = "Stock not added!"
        render "portfolios/edit"
      end
    else
      flash.now[:alert] = "Stock not found!"
      render "portfolios/edit"
    end
  end

  def update
    @stock = Stock.new(stock_params)
    @stock.update
    redirect_to portfolio_path(@stock.article)
  end

  private

  def stock_params(stock)
    s = stock["quote"]
    {symbol: s["symbol"], name: s["Name"], price: s["Ask"], change: s["ChangeinPercent"].to_f, high: s["DaysHigh"], low: s["DaysLow"], amount: params[:stock][:amount]}
  end

  def stock_api(symbol)
    StockQuote::Stock.json_quote(symbol)
  end
  def check_stock(stock)
    stock["quote"]["Name"]
  end

end
