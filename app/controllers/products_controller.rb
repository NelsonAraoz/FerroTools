class ProductsController < ApplicationController
	layout 'categories'
  def new
    if(current_user.rol=='admin')
    @new_product=Subcategory.find(params[:id]).products.new
    @selected_subcategory=@new_product.subcategory
    @category=@selected_subcategory.category
    @picture=Picture.new
    else
      redirect_to root_path
    end
  end
  def view
    @product=Product.find(params[:prodid])
    @pictures=@product.pictures
    @selected_subcategory=Subcategory.find(params[:subid])
    @category=Category.find(params[:id])
  end
  def destroy
    product=Product.find(params[:id])
     product.pictures.each do |picture|
              picture.destroy
          end
          product.destroy
           flash[:alert]="Se elimino el producto y todo lo relacionado con este"
    redirect_to root_path
  end
  def edit
    if(current_user.rol=='admin')
    @product=Product.find(params[:id])
    @pictures=@product.pictures
    @selected_subcategory=@product.subcategory
    @category=@selected_subcategory.category
    else
      redirect_to root_path
    end
  end
  def update
    params.permit!
    @product=Product.find(params[:id])
    @product.update(params.require(:product).permit(:name,:brand,:code,:price,:subcategory_id,:stock))
    if(!params[:product][:picture].nil?)
    params[:product][:picture].each do |pic|
    @picture=Picture.new(:picture=>pic)
    @picture.product_id=@product.id
    @picture.save
    end
    end
    flash[:alert]="Producto actualizado exitosamente"
    redirect_to "/categories/"+@product.subcategory.category_id.to_s+"/"+@product.subcategory_id.to_s
  end
  def create
    params.permit!
    @product=Product.new(params.require(:product).permit(:name,:brand,:code,:price,:subcategory_id,:stock))
    # flash[:alert]=params[:subcategory][:category_id]
    @product.save
    if(!params[:product][:picture].nil?)
    params[:product][:picture].each do |pic|
    @picture=Picture.new(:picture=>pic)
    @picture.product_id=@product.id
    @picture.save
    end
    end
    flash[:alert]="Producto creado exitosamente"
    redirect_to "/categories/"+@product.subcategory.category_id.to_s+"/"+@product.subcategory_id.to_s
  end

end