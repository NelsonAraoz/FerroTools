class Subcategory < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name,  use: [:slugged, :finders] 
	belongs_to :category
	has_many :products
	def has_dependencies
		self.products.each do |product|
			if(product.orders.size>0)
				return true
			end
		end
		return false
	end
end