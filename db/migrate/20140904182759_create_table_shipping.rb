class CreateTableShipping < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
    	 t.references :deliver, index: true 
    	 t.string :status,:default => 'pending'
    	 t.integer :messenger_id
    	 t.date :delivery
    	 t.timestamps
    end
  end
end
