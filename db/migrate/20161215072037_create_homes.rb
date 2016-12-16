class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :zip
      t.integer :beds
      t.integer :baths
      t.integer :lot_sqft
      t.string :area
      t.string :subtype
      t.boolean :reo
      t.boolean :short_sale
      t.boolean :hud
      t.boolean :auction
      t.timestamps
    end
  end
end
