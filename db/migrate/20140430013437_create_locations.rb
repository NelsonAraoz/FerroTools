class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :number
      t.string :address
      t.float :longitude
      t.float :latitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
