class AddColumnSendedToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :sended, :int, default: 0, null: false
  end
end
