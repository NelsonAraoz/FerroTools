class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :delivers
  has_many :locations
  validates :name,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :lastname,
	:presence  => { :message => " es requerido, no puede ser nulo" }
	validates :email,
		:presence  => { :message => " es requerido, no puede ser nulo" }

	validates :phone,
	:length => {
		:minimum => 7,
		:maximun=>8,
		 :message => " debe tener como minimo 7 y como maximo 8 caracteres"
	}
	
	
	 
end
