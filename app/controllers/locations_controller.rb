class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :xml
  # GET /locations
  # GET /locations.json
  def index
    @locations = current_user.locations
    respond_with @locations
  end
  def login
    if(params[:name]=="pedro" && params[:pass]=="pedro")
      respond_with '{"res": true}'
    else
      respond_with '{"res": false}'
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location=Location.find(params[:id])
    if @location.user_id==current_user.id
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
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @location.user_id=current_user.id
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
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
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
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
