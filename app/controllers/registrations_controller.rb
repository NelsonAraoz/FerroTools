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
	
end
