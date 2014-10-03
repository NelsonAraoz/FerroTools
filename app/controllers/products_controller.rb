class ProductsController < ApplicationController
  
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
  def search
    @filtered_products=filter_products(Product.all,params[:product_search])
    @products=Kaminari.paginate_array(@filtered_products).page(params[:page]).per(10)
  end
  def view

    @view_image=true
    @category=Category.find(params[:id])
    @selected_subcategory=@category.subcategories.find(params[:subid])
    @product=@selected_subcategory.products.find(params[:prodid])
    @title=@product.name
    @pictures=@product.pictures
    @order=Order.new
    if(!@product.visible)
      redirect_to root_path
    end
  end
  def dependencies
    @product=Product.find(params[:id])
    @cart_size=@product.orders.where(:deliver_id=>nil).size
    @deliveries=@product.orders.where.not(:deliver_id=>nil)
  end
  def destroy
    @product=Product.find(params[:id])
    if(@product.orders.size==0)
    @product.remove_myself
    flash[:alert]="El producto y sus imagenes fueron eliminados correctamente!"
    redirect_to root_path
  else
    redirect_to '/products/dependencies/'+@product.id.to_s
  end
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
    if (@product.update(params.require(:product).permit(:name,:brand,:code,:price,:subcategory_id,:stock)))
    if(!params[:product][:picture].nil?)
    params[:product][:picture].each do |pic|
    @picture=Picture.new(:picture=>pic)
    @picture.product_id=@product.id
    @picture.save
    end
    end
    flash[:alert]="Producto actualizado exitosamente"
    redirect_to "/categories/"+@product.subcategory.category_id.to_s+"/"+@product.subcategory_id.to_s

  else
      @pictures=@product.pictures
       render action: 'edit'

  end
      end
  def create
    params.permit!
    @new_product=Product.new(params.require(:product).permit(:name,:brand,:code,:price,:subcategory_id,:stock))
    # flash[:alert]=params[:subcategory][:category_id]
    if(@new_product.save)
    if(!params[:product][:picture].nil?)
    params[:product][:picture].each do |pic|
    @picture=Picture.new(:picture=>pic)
    @picture.product_id=@new_product.id
    @picture.save
    end
    end
     flash[:alert]="Producto creado exitosamente"
    redirect_to "/categories/"+@new_product.subcategory.category_id.to_s+"/"+@new_product.subcategory_id.to_s
  
  else
   render action: 'new'
  end
   end
  private
  def filter_products(products,param)
    @filtered=[]
    products.each do |product|
      if(product.filter(param))
        @filtered.push(product)
      end

    end
    @filtered
  end

end