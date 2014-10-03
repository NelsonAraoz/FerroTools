class Location < ActiveRecord::Base
	belongs_to :user
	has_many :delivers
	validates :address,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :number,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :latitude,
	:presence  => { :message => " de su direccion es requerida" }
	validates :longitude,
	:presence  => { :message => " de su direccion es requerida" }
end
