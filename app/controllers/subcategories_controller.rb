class SubcategoriesController < ApplicationController
	layout 'categories'
 def destroy
  subcategory=Subcategory.find(params[:id])
  subcategory.products.each do |product|
          product.pictures.each do |picture|
              picture.destroy
          end
          product.destroy
      end
      subcategory.destroy
      flash[:alert]="Se elimino la sub-categoria y todo lo relacionado con esta"
    redirect_to root_path
 end
  def new
    if(current_user.rol=='admin')
    @category=Category.find(params[:id])
    @new_subcategory=@category.subcategories.new
    else
      redirect_to root_path
    end
  end
  def edit
    @subcategory=Subcategory.find(params[:id])
  end
  def update
    @subcategory=Subcategory.find(params[:id])
    @subcategory.update(params[:subcategory].permit(:name))
    flash[:alert]="Sub-categoria actualizada exitosamente"
    redirect_to root_path
  end
  def create
    params.permit!
    @subcategory=Subcategory.new(params[:subcategory])
     flash[:alert]=params[:subcategory][:category_id]
    @subcategory.save
    flash[:alert]="Sub-categoria creada exitosamente"
    redirect_to "/categories/"+@subcategory.category_id.to_s+"/"+@subcategory.id.to_s
  end

end