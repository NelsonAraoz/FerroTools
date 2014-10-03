class CategoriesController < ApplicationController
def dependencies
  @category=Category.find(params[:id])
  @subcategories=[]
  @category.subcategories.each do |subcategory|
      if(subcategory.has_dependencies)
        @subcategories<<subcategory
      end
   end
 end
  def destroy
    @category=Category.find(params[:id])
    if(!@category.has_dependencies)
    @category.subcategories.each do |subcategory|
      subcategory.products.each do |product|
          product.destroy
      end
      subcategory.destroy
    end
    @category.destroy
    flash[:alert]="La categoria y todo lo relacionado a esta fueron eliminadas"
    redirect_to root_path
  else
    redirect_to '/categories/dependencies/'+@category.id.to_s
  end
  end
  def display
         
   @category=Category.find(params[:id])
   if(@category.visible)
    if(@category!=nil)
    @subcategories=@category.subcategories.where(:visible=>true)
    end
    if(params[:subid]!=nil)
      @selected_subcategory=@category.subcategories.where(:visible=>true).find(params[:subid])
      if(!@selected_subcategory.blank?)
      @products=@selected_subcategory.products.where(:visible=>true).sort_by{|e| e[:name]}
      else
        redirect_to root_path
      end
    end
  else
    redirect_to root_path
  end
  end

  def new
    if(current_user!=nil && current_user.rol=='admin')
    @new_category=Category.new
    else
      redirect_to root_path
    end
  end
  def edit
    @category=Category.find(params[:id])
  end
  def update
    @category=Category.find(params[:id])
    @category.update(params[:category].permit(:nombre))
    flash[:alert]="Categoria actualizada exitosamente"
    redirect_to root_path
  end
  def create
    params.permit!
    @category=Category.new(params[:category])
    @category.save
    flash[:alert]="Categoria creada exitosamente"
    redirect_to root_path
  end

end