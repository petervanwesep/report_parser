class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.datetime :purchased_at
      t.integer :price
      t.references :home, index: true, foreign_key: true
      t.timestamps
    end
  end
end
