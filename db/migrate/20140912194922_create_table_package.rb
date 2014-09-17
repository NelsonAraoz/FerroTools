class CreateTablePackage < ActiveRecord::Migration
  def change
    create_table :packages do |t|
    	t.references :shipping, index: true
    	t.references :order, index: true 
    	t.integer :amount
    	t.timestamps
    end
  end
end
