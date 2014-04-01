class PicturesController < ApplicationController
def new
@picture=Picture.new
@pictures=Picture.all
end
def delete
	@picture=Picture.find(params[:id])
	@picture.destroy
	flash[:alert]="Imagen borrada con exito"
	redirect_to :back
end
def create
if(!params[:picture][:picture].nil?)
	params[:picture][:picture].each do |pic|
		@picture=Picture.new(:picture=>pic)
		@picture.save
	end

end
end
end
