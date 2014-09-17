class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	belongs_to :deliver
	has_many :packages
	def amount_empty(d_amount)
		self.amount=self.amount-d_amount
		self.save
		self.amount==0
	end
	def filter(name,brand,from,to)
		result=true
		if(!name.blank?)
		result=self.product.name.downcase.include?(name.downcase)
		end
		if(!brand.blank?)
		result=result&&self.product.brand.downcase.include?(brand.downcase)
		end
		if(!from.blank? && to.blank?)
		result=result&&self.updated_at.to_date==from.to_date
		elsif(!from.blank? && !to.blank?)
		result=result&&(self.updated_at.to_date>=from.to_date && self.updated_at.to_date<=to.to_date)
		end
		result
	end

end