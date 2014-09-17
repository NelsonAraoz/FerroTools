class CreateTableDeliver < ActiveRecord::Migration
  
def change
  create_table :delivers do |t|
     t.references :user, index: true 
     t.references :location, index: true 
     t.timestamps
    end
  end



end
