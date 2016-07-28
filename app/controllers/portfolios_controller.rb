class PortfoliosController < ApplicationController
  include PortfoliosHelper
  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      flash[:success] = "Portfolio '#{@portfolio.name}' Created!"
      redirect_to @portfolio
    else
      flash.now[:alert] = "Portfolio not created!"
      render :edit
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @stock = Stock.new
    @stock.portfolio_id = @portfolio.id
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update(portfolio_params)
      flash[:success] = "'#{@portfolio.name}' Updated!"
      redirect_to @portfolio
    else
      flash.now[:alert] = "Portfolio not updated!"
      render :edit
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.destroy
      flash[:success] = "'#{@portfolio.name}' Deleted!"
    else
      flash[:alert] = "Portfolio not deleted!"
    end
    redirect_to portfolios_path
  end


  private

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end

end
