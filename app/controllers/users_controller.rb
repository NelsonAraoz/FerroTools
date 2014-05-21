class UsersController < ApplicationController
def update
		#super
		current_user.name=params[:user][:name]
		current_user.lastname=params[:user][:lastname]
		current_user.phone=params[:user][:phone]
		current_user.address=params[:user][:address]
		current_user.save
		flash[:alert]="usuario editado exitosamente!"
		redirect_to root_path
 end

 def change_password
 	@user=current_user
 end

 def update_password
 	
 end
end
