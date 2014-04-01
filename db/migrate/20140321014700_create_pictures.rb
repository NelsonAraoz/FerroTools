class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.references :product, index: true 
      t.timestamps
    end
    add_attachment :pictures, :picture
  end
end
