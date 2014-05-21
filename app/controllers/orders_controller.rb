class OrdersController < ApplicationController
	 layout 'categories'
    skip_before_filter :verify_authenticity_token  
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
    @product=Product.find(@order.product_id)
    if(@order.amount==nil || @order.amount<=0)
      @order.amount=1
    end
    if(@order.amount>@product.stock)
      flash[:alert]="No se cuenta con la cantidad suficiente"
        redirect_to :back
    else
    @product=Product.find(@order.product_id)
    flash[:alert]="se pidio "+@order.amount.to_s+" unidades de "+@product.name
    @order.user_id=current_user.id
    @order.save
    @product.stock=@product.stock-@order.amount
    @product.save
    redirect_to root_path
  end
  end
  def destroy
    @order=Order.find(params[:id])
    @product=Product.find(@order.product_id)
    @product.stock=@product.stock+@order.amount
    @product.save
    @order.destroy
    flash[:alert]="Se elimino la orden correctamente"
    redirect_to '/orders/my_orders'
  end
  def edit
    @order=Order.find(params[:id])
  end
  def update
     @order=Order.find(params[:id])


     @product=Product.find(@order.product_id)
     if(params[:order][:amount].to_i>@product.stock+@order.amount)
        flash[:alert]="No se cuenta con la cantidad suficiente"
        redirect_to :back
     else
    @product.stock=@product.stock+@order.amount
    @order.update(params.require(:order).permit(:amount))
    @product.stock=@product.stock-@order.amount
    @product.save
    flash[:alert]="Pedido actualizado exitosamente"
    redirect_to '/orders/my_orders'
    end
  end
  def uncheck
    @order=Order.find(params[:id])
      @order.checked=false
      @order.save
      redirect_to '/orders/my_orders'
  end
  def uncheck_send
    @order=Order.find(params[:id])
      @order.sended=false
      @order.save
      redirect_to '/orders/all_orders'
  end
def my_orders
  if(current_user==nil || current_user.rol!="regular")
    redirect_to root_path
  else
    @orders=current_user.orders.where(:checked=>false)
    @locations=current_user.locations
    if(@locations.size==0)
      flash[:alert]="debe registrar por lo menos una direccion antes de hacer un pedido"
      redirect_to "/locations/new"
    end
  end
end
def my_checked_orders
  @orders=current_user.orders.where(:checked=>true)
end
def my_sended_orders
  if(current_user!=nil && current_user.rol=="admin")
  @locations=Location.all
  @orders=Order.where(:checked=>true,:sended=>true)
else 
  redirect_to root_path
end
end

def all_orders
  if(current_user!=nil && current_user.rol=="admin")
  @locations=Location.all
  @orders=Order.where(:checked=>true,:sended=>false)
else 
  redirect_to root_path
end
  end

def confirm
  @my_orders=params[:pedir].to_a
  @my_orders.each do |order|
    o=Order.find(order.to_s)
    if(o.user_id==current_user.id)
    o.checked=true
    o.location_id=params[:location].to_s
    o.save
    end
  end
  flash[:alert]="Se realizo el pedido correctamente"
    redirect_to '/orders/my_orders'
end

  def confirm_order_send
    @my_orders=params[:llevar].to_a
   @my_orders.each do |order|
    o=Order.find(order.to_s)
    o.sended=true
    o.save
  end
   flash[:alert]="Se realizo el cambio correctamente"
    redirect_to root_path
  end

end