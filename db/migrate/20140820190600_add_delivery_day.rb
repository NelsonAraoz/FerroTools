class AddDeliveryDay < ActiveRecord::Migration
  def change
  	add_column :orders, :delivery, :date
  end
end
