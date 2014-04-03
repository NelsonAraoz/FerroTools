class CategoriesController < ApplicationController
	layout 'categories'
  def destroy
    category=Category.find(params[:id])
    category.subcategories.each do |subcategory|
      subcategory.products.each do |product|
          product.pictures.each do |picture|
              picture.destroy
          end
          product.destroy
      end
      subcategory.destroy
    end
    category.destroy
    flash[:alert]="Se elimino la categoria y todo lo relacionado con esta"
    redirect_to root_path
  end
  def display
         
   @category=Category.find_by_id(params[:id])
   @subcategories=[]
    if(@category!=nil)
    @subcategories=@category.subcategories
    end
    @products=[]
    if(params[:subid]!=nil)
      @order=Order.new
      @selected_subcategory=@category.subcategories.find(params[:subid])
      @products=@selected_subcategory.products
      if(params[:prodid]!=nil)
        @products=@selected_subcategory.products.where(:id=>params[:prodid])
        @pictures=@products.first.pictures
      end
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