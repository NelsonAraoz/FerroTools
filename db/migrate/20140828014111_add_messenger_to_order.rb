class AddMessengerToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :messenger_id , :integer
  end
end
