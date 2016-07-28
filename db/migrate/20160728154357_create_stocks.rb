class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :price
      t.float :change
      t.float :high
      t.float :low
      t.integer :amount
      t.references :portfolio
      t.timestamps null: false
    end
  end
end
