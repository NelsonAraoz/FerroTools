class RegistrationsController < Devise::RegistrationsController
	def new
		super
	end
	def create
		super
	end
	def edit
		@user=current_user
	end
	def update
		#super
		current_user.nombre=params[:user][:nombre]
		current_user.save
	end
end
