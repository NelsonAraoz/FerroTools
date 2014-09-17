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
 def index
  if(current_user!=nil && current_user.rol=="admin")
    @users=User.where(:rol=>'regular')
  else
    redirect_to root_path
  end
 end
 def new_messenger
 	@user=User.new
 end
 def edit_messenger
  @user=User.find(params[:id])
 end
 def messenger_index
 	@messengers=User.where(:rol=>'messenger')
 end
 def update_messenger
   @user=User.find(params[:id])
 if messenger_params[:password].blank?
      messenger_params.delete("password")
      messenger_params.delete("password_confirmation")
    end
   if @user.update(messenger_params)
    flash[:alert]="Mensajero actualizado"
    redirect_to '/users/messenger_index'
    
   else
    flash[:alert]="Error"
    render '/users/edit_messenger/'
   end
  
 end
 def create_messenger
	
 	params[:user]=params[:user].merge(:confirmed_at=>Time.now,:rol=>"messenger")
 	 
 		@user= User.new(messenger_params)
 	if @user.save
 		flash[:alert]="Mensajero creado correctamente"
 		redirect_to root_path
 	else
 		render new_messenger_path
 	end
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

 def destroy
 	@user=User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to messenger_index_path }
      format.json { head :no_content }
    end
  end
  #SERVICES

  def login_service
  	@user=User.find_by_email(params[:email])
  	if(@user!=nil && @user.valid_password?(params[:password]))
  		render json:  '{"res": true}'
  	else
  		render json: '{"res": false}'
  	end
  end

  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def messenger_params
      params.require(:user).permit(:name, :lastname, :phone, :address, :rol,:email,:confirmed_at,:password_confirmation,:password)
    end

end
