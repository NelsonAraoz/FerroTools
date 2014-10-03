class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]
  # GET /presentations
  # GET /presentations.json

  # GET /presentations/1
  # GET /presentations/1.json
  def show
  end


  # GET /presentations/1/edit
  def edit
  end



  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        format.html { redirect_to root_path, notice: 'Presentation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(1)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presentation_params
      params.require(:presentation).permit(:content)
    end
end
