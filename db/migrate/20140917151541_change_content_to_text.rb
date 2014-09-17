class ChangeContentToText < ActiveRecord::Migration
  def change
  	change_column :presentations, :content, :text
  end
end
