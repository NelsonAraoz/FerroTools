class Category < ActiveRecord::Base
	extend FriendlyId
 	 friendly_id :nombre,  use: [:slugged, :finders] 
	has_many :subcategories
	
  def has_dependencies
		self.subcategories.each do |subcategory|
			if(subcategory.has_dependencies)
				return true
			end
		end
		return false
	end
end