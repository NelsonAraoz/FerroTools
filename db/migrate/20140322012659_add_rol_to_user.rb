class AddRolToUser < ActiveRecord::Migration
  def change
  	add_column :users, :rol , :string, :default=>'regular'
  end
end
