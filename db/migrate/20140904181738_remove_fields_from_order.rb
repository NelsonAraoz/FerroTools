class RemoveFieldsFromOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :checked
  	remove_column :orders, :location_id
  	remove_column :orders, :sended
  	remove_column :orders, :delivery
  	remove_column :orders, :messenger_id
  end
end
