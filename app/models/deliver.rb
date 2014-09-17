class Deliver < ActiveRecord::Base
	belongs_to :user
	belongs_to :location
	has_many :orders
	has_many :shippings
	 def sumar(id,rol)
      suma=0
      if(rol=="regular")
      @s=self.shippings.where(:status=>'sended')
      else
      	@s=self.shippings
      end
      @s.each do |shipping|
        suma=suma+shipping.packages.where(:order_id=>id).sum(:amount)
      end
      suma
    end
    def is_complete(rol)
      self.orders.each do |order|
        @total=sumar(order.id,rol)
        if(@total<order.amount)
          return false
        end
      end
      true
    end
    def filter_delivery(address,client)
    	result=true
		if(!address.blank?)
		result=self.location.address.downcase.include?(address.downcase) || self.location.number.to_s.downcase.include?(address.downcase) 
		end
		if(!client.blank?)
		result=result&&(self.user.name.downcase.include?(client.downcase)||self.user.lastname.downcase.include?(client.downcase))
		end
		result
    end
	def filter(address,client,status,from,to,rol)
		result=filter_delivery(address,client)
		if(!from.blank?)
		result=result&&self.updated_at.to_date==from.to_date
		end
		if(!status.blank?)
			if(status=="2")
				result=result&&!self.is_complete(rol)
			elsif(status=="3")
				result=result&&self.is_complete(rol)
			
			end
			
		end
		if(!to.blank? && !self.delivery.blank?)
		result=result&&self.delivery.to_date==to.to_date
		end
		if(!to.blank? && self.delivery.blank?)
		result=false
		end
		result
	end


end