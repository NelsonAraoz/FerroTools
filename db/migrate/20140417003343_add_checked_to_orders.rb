class AddCheckedToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :checked, :int, default: 0, null: false
  end
end
