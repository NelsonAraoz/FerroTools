class Change2Text < ActiveRecord::Migration
  def change
  	 change_column :presentations, :content, :text
  end
end
