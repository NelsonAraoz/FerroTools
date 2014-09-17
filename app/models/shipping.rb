class Shipping < ActiveRecord::Base
	belongs_to :deliver
	belongs_to :messenger, foreign_key: 'messenger_id', class_name: 'User'
	has_many :packages
	def total
		@total=0
		packages.each do |package|
			@total=@total+(package.amount*package.order.product.price)
		end
		@total
	end
	def filter(address,client,status,from,to,messenger,rol)
		result=self.deliver.filter_delivery(address,client)
		if(rol=='regular' && self.status=='pending')
			result=false
		end
		if(!messenger.blank? && !self.messenger.nil?)
		result=result&&(self.messenger.name.downcase.include?(messenger.downcase)||self.messenger.lastname.downcase.include?(messenger.downcase))
		end
		if(!messenger.blank? && self.messenger.nil?)
			result=false
		end
		if(!from.blank?)
		result=result&&self.updated_at.to_date==from.to_date
		end
		if(!to.blank? && !self.delivery.blank?)
		result=result&&self.delivery.to_date==to.to_date
		end
		if(!to.blank? && self.delivery.blank?)
		result=false
		end
		result
	end

def filter_my_shipping(address,status,from,to,messenger,rol)
		self.filter(address,nil,status,from,to,messenger,rol)
	end


end