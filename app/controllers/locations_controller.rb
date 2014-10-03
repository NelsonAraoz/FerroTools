class LocationsController < ApplicationController
    protect_from_forgery :only => [:login]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  respond_to :json,:html
  # GET /locations
  # GET /locations.json
  def index
    if((current_user!=nil && current_user.rol!="messenger"))
    if (current_user!=nil && current_user.rol=="admin")
      @user=User.find(params[:id])
    elsif(current_user!=nil && current_user.rol=="regular")
      @user=current_user
    end
    @locations = @user.locations
    
  else
    redirect_to root_path
  end
  end
  

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location=Location.find(params[:id])
    if @location.user_id==current_user.id || (current_user!=nil && current_user.rol=="admin")
    @hash = Gmaps4rails.build_markers(@location) do |l, marker|
  marker.lat l.latitude
  marker.lng l.longitude
  marker.infowindow l.address.to_s+"# "+l.number.to_s
end
else
redirect_to root_path
end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location=Location.find(params[:id])
    if @location.user_id==current_user.id || (current_user!=nil && current_user.rol=="admin")
    @hash = Gmaps4rails.build_markers(@location) do |l, marker|
  marker.lat l.latitude
  marker.lng l.longitude
  marker.infowindow l.address.to_s+"# "+l.number.to_s
end
else
redirect_to root_path
end
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @location.user_id=current_user.id
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Ubicacion creada correctamente!' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Ubicacion actualizada correctamente!' }
        format.json { head :no_content }
      else
        format.html { redirect_to '/locations/'+@location.id.to_s+'/edit',notice: 'Ingrese una direccion y un numero de casa!' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    if(current_user!=nil && current_user.rol=="admin"||(current_user.rol=="regular" && current_user.id==@location.user_id))
  @user=@location.user
  if(@location.delivers.size>0)
    
  flash[:alert]="No se puede eliminar hay pedidos a esta direccion!"
  else
@location.destroy
flash[:alert]="Eliminado correctamente"
  end
  if(current_user.rol=="admin")
    redirect_to '/locations/index/'+@user.id.to_s
  else
    redirect_to locations_url
  end
  else
    redirect_to root_path
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:number, :address, :longitude, :latitude, :gmaps)
    end
end
