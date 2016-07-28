class Stock < ActiveRecord::Base
  validates :amount, numericality: { only_integer: true }
  belongs_to :portfolios
end
