class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :price
      t.datetime :listed_at
      t.references :home, index: true, foreign_key: true
      t.timestamps
    end
  end
end
