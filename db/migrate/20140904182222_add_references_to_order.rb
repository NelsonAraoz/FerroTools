class AddReferencesToOrder < ActiveRecord::Migration
  def change
  add_column :orders, :deliver_id , :integer
  
  end
end
