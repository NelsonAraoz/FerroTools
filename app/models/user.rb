class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :locations
  validates :name,
	:presence  => { :message => " es requerido, no puede ser nulo" },
	:length => {
		:minimum => 2,
		:allow_blank => TRUE
	}
	validates :lastname,
	:presence  => { :message => " es requerido, no puede ser nulo" },
	:length => {
		:minimum => 2,
		:allow_blank => TRUE
	}
	
	 
end
