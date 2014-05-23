class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token 
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
 	@user=current_user
 	 	if(current_user.valid_password?(params[:user][:current_password]))
 	  if(params[:user][:password]==params[:user][:password_confirmation])
 	  	if(params[:user][:password].blank?)
 	  		flash[:alert]="Los passwords no pueden estar en blanco"
 	  	redirect_to :back
 	  	else
 	  current_user.password=params[:user][:password]
 	  if current_user.save
 	  flash[:alert]="Se cambio el password correctamente"
 	    sign_in @user, :bypass => true
 	    redirect_to root_path
 	   else
 	   	flash[:alert]="El password debe tener al menos 8 caracteres"
 	  	redirect_to :back
 	   end
 	  
 	end
 	  else
 	  	flash[:alert]="Los passwords no coinciden"
 	  	redirect_to :back
 	  end
 	else
 	  flash[:alert]="Password actual incorrecto"
 	  redirect_to :back
 	end
    



 	
    
 end
end
