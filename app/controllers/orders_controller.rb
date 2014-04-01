class OrdersController < ApplicationController
	
  def new
    if(current_user!=nil && current_user.rol=='admin')
    @product=Product.find(params[:id])
    @pictures=@product.pictures
    @order=Order.new
    else
      flash[:alert]="Debe loggearse para ver este contenido"
      redirect_to '/users/sign_in'
    end
  end

  def create
    params.permit!
    @order=Order.new(params[:order])
    if(@order.amount==nil || @order.amount<=0)
      @order.amount=1
    end
    @product=Product.find(@order.product_id)
    flash[:alert]="se pidio "+@order.amount.to_s+" unidades de "+@product.name
    @order.user_id=current_user.id
    @order.save
    redirect_to root_path
  end
def my_orders
  @orders=current_user.orders
end
end