class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :name
    	t.string :code
    	t.string :brand
    	t.float :price
    	t.integer :stock
      	t.references :subcategory, index: true 
      	t.timestamps
    end
  end
end
