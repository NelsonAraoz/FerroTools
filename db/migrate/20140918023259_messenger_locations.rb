class MessengerLocations < ActiveRecord::Migration
  def change
  	 create_table :messenger_locations do |t|
     t.references :user, index: true 
        t.float :longitude
      t.float :latitude
    
     t.timestamps
    end
  end
end
