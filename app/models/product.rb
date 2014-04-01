class Product < ActiveRecord::Base
	belongs_to :subcategory
	has_many :pictures
	has_many :orders 
end