class AddVisible < ActiveRecord::Migration
  def change
  	add_column :categories, :visible , :boolean, :default=>true
  	add_column :subcategories, :visible , :boolean, :default=>true
  	add_column :products, :visible , :boolean, :default=>true
  end
end
