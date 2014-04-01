class AddPedidos < ActiveRecord::Migration
  def change
  	 create_table :orders do |t|
    	t.integer :amount
      	t.references :user, index: true 
      	t.references :product, index: true
      	t.timestamps
      end
  end
end
