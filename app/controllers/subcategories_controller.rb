class SubcategoriesController < ApplicationController
  
 def destroy
  @subcategory=Subcategory.find(params[:id])
  if(!@subcategory.has_dependencies)
  @subcategory.products.each do |product|
          product.remove_myself
      end
      @subcategory.destroy
      flash[:alert]="La sub-categoria y productos pertenecientes fueron eliminados!"
    redirect_to root_path
  else
    redirect_to '/subcategories/dependencies/'+@subcategory.id.to_s
  end
 end
 def dependencies
  @subcategory=Subcategory.find(params[:id])
  @products=[]
  @subcategory.products.each do |product|
    if(product.orders.size>0)
      @products<<product
    end
  end
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
    @category=@subcategory.category
  end
  def update
    @subcategory=Subcategory.find(params[:id])
    @subcategory.update(params[:subcategory].permit(:name))
    flash[:alert]="Sub-categoria actualizada exitosamente"
    redirect_to "/categories/"+@subcategory.category_id.to_s+"/"+@subcategory.id.to_s
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