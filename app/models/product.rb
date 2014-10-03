class Product < ActiveRecord::Base
	validates :name,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :code,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :brand,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :price,
		:numericality => { :greater_than_or_equal_to => 0  ,:message=>" debe ser un numero mayor a 0"}

	validates :stock,
		:numericality => { :greater_than_or_equal_to => 0 , only_integer: true  ,:message=>" debe ser un numero entero mayor a 0"}

	
	
	extend FriendlyId
  	friendly_id :slug_candidates,  use: [:slugged, :finders] 
  	def slug_candidates
    [
      :name,
      [:name, :brand],
      [:name, :brand, :code]
    ]
  end
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
	def remove_myself
		self.pictures.each do |picture|
			picture.destroy
		end
		self.destroy
	end
end