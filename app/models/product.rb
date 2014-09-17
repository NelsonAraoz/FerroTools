class Product < ActiveRecord::Base
	belongs_to :subcategory
	has_many :pictures
	has_many :orders 
	def filter(param)
		result=true
		if(!param.blank?)
			result=(self.name.downcase.include?(param.downcase) || self.brand.downcase.include?(param.downcase) || self.code.downcase.include?(param.downcase) )
		end
		result
	end
end