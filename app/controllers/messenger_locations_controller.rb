class MessengerLocationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
    if(current_user!=nil && current_user.rol=="admin")
    @messenger=User.find(params[:id])
  else
    redirect_to root_path
    end
  end
  def get_location
    @messenger_location=MessengerLocation.where(:user_id=>params[:id])
    render json: @messenger_location.first
  end
  #services
  def update
    @user=User.find(params[:id])
    @l=@user.messenger_locations
    if(@l.blank?)
      @location=@user.messenger_locations.new
      @location.latitude=params[:latitude]
      @location.longitude=params[:longitude]
      @location.save
      else
        @location=@l.first
      @location.latitude=params[:latitude]
      @location.longitude=params[:longitude]
      @location.save
         
    end
    render json:  '{"res": true}'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_deliver
     # @location = Location.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def location_params
     # params.require(:shipping).permit(:status,:delivery,:messenger_id,:deliver_id)
    #end
end
