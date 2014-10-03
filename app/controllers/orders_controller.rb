class OrdersController < ApplicationController
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
    @orders=Order.where(:deliver_id=>nil,:user_id=>current_user.id,:product_id=>@product.id)
    if(@orders.size==0)
    @order.user_id=current_user.id
    @order.save
    flash[:alert]="se pidio "+@order.amount.to_s+" unidades de "+@product.name
    else
      @existing_order=@orders.first
      @existing_order.amount=@existing_order.amount+@order.amount
      @existing_order.save
      flash[:alert]="se aumento "+@order.amount.to_s+" unidades de "+@product.name
    end
    @product.stock=@product.stock-@order.amount
    @product.save
    redirect_to '/orders/my_orders'
  end
  end
  def removing_from_kart
    if(current_user!=nil && current_user.rol=="admin")
      if(params[:from].blank?)
        flash[:alert]="Ingrese una fecha"
        redirect_to :back
      else
        @date=params[:from]
         @product=Product.find(params[:id])
   
      @orders=filter_order(Order.where(:product_id=>@product.id,:deliver_id=>nil),@date)
      @orders.each do |order|
        @product=Product.find(order.product_id)
        @product.stock=@product.stock+order.amount
        @product.save
        order.destroy
      end
        flash[:alert]="Eliminados correctamente"
        redirect_to :back
      
      end
    else
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
    redirect_to :back
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
      if(params[:order][:amount].to_i<=0)
        flash[:alert]="Debe ser un numero positivo"
    redirect_to :back
      else
    @product.stock=@product.stock+@order.amount
    @order.update(params.require(:order).permit(:amount))
    @product.stock=@product.stock-@order.amount
    @product.save
    flash[:alert]="Pedido actualizado exitosamente"
    redirect_to :back
  end
    end
  end
def my_orders
  if(current_user==nil || current_user.rol=="messenger")
    redirect_to root_path
  else
    @exist=!params[:product].blank? || !params[:brand].blank? || !params[:from].blank? || !params[:date_to].blank? 
    if(current_user.rol=="regular")
    @locations=current_user.locations
    if(@locations.size==0)
      flash[:alert]="debe registrar por lo menos una direccion antes de hacer un pedido"
      redirect_to "/locations/new"
    end
    @all=current_user.orders
    else
      @all=User.find(params[:id]).orders
    end
    @orders=filter_orders(@all.where(:deliver_id=>nil),params[:product],params[:brand],params[:from],params[:date_to])
    

  end
end
def add_order
  @order=Order.find(params[:id])
  @product=@order.product
  @amount=params[:amount].to_i
  if(@amount>0)
  if(@amount<=@product.stock)
    @product.stock=@product.stock-@amount
    @order.amount=@order.amount+@amount
    @product.save
    @order.save
    flash[:alert]="se aumento correctamente"
    redirect_to :back
  else
    flash[:alert]="Monto excede"
    redirect_to :back
  end
else
   flash[:alert]="Introduzca un valor positivo"
    redirect_to :back
end
end
def remove_order
  @order=Order.find(params[:id])
  @deliver=@order.deliver
  @amount=params[:amount].to_i
  @total=@order.amount-@order.packages.sum(:amount)
  if(@amount>0)
  if(@amount<=@total)
    if(@order.amount_empty(@amount))
      @order.destroy
      if(@deliver.orders.size==0)
        @deliver.destroy
      end
    
    end
     flash[:alert]="Disminuido correctamente"
    redirect_to :back
  else
    flash[:alert]="Monto excede"
    redirect_to :back
  end
else
   flash[:alert]="Introduzca un valor positivo"
    redirect_to :back
end
end
def my_checked_orders
  if(current_user!=nil && current_user.rol=='regular')
    @shippings=get_shippings(current_user.delivers,params[:id])
    if(params[:status].to_i>1&&params[:status].to_i<4)
      status=["confirmed","taked","sended"]
      @shippings=@shippings.where(:status=>status[params[:status].to_i-2])
    end
    @filter_shippings=filter_my_shippings(@shippings,params[:address],params[:status],params[:from],params[:date_to],params[:messenger],current_user.rol)
     @my_shippings=Kaminari.paginate_array(@filtered_shippings).page(params[:page]).per(5)
      @status=Hash["confirmed"=>"Confirmado","taked"=> "En camino","sended"=>"Enviado","pending"=>"Pendiente"]
      @colors=Hash["confirmed"=>"blue","taked"=> "#31B404","sended"=>"green","pending"=>"#B18904"]
      @exist=!params[:address].blank?  || !params[:from].blank? || !params[:date_to].blank? || !params[:status].blank?
else
  redirect_to root_path
end
end
def remove_kart
  if(current_user!=nil && current_user.rol=="admin")
    if(params[:from].blank?)
      params[:from]=DateTime.now.to_date
     else
      @date=params[:from]
    end
    @product=Product.find(params[:id])
    @orders=filter_order(Order.where(:product_id=>@product.id,:deliver_id=>nil),params[:from])
  else
    redirect_to root_path
  end
end
def delete_items
 if(current_user!=nil )

  @delivery=Deliver.find(params[:id])
  @orders=@delivery.orders
  @confirmed=current_user.rol=='regular'
  @user=@delivery.user
  @is_shipping=@delivery.shippings.where(:status=>'taked').size>0
  if(@confirmed && current_user.id!=@user.id)
    redirect_to root_path
  end
else
  redirect_to root_path
end
end

def my_sended_orders
  if(current_user!=nil && current_user.rol=="admin")
    @messenger=false
        @exist=!params[:address].blank? || !params[:client].blank? || !params[:from].blank? || !params[:date_to].blank? || !params[:status].blank?
        if(params[:status].blank?)
            params[:status]="1"
          end
        if(params[:status]=="1")
         @delivery= Shipping.all.order('updated_at DESC')
        else
          
          @status=["pending","confirmed","taked","sended"]
         @delivery=Shipping.where(:status=>@status[params[:status].to_i-2]).order('updated_at DESC')
        end
        if(!params[:id].blank?)
          @delivery=@delivery.where(:deliver_id=>params[:id])
        elsif(!params[:messenger_id].blank?)
            @delivery=@delivery.where(:messenger_id=>params[:messenger_id])   
            @messenger=true 
        end
        @filtered_deliveries=filter_all_shippings(@delivery,params[:address],params[:status],params[:client],params[:from],params[:date_to],params[:messenger],current_user.rol)
           @deliveries=Kaminari.paginate_array(@filtered_deliveries).page(params[:page]).per(5)
            @status=Hash["pending"=>"Pendiente","confirmed"=>"Confirmado","taked"=> "En camino","sended"=>"Enviado"]
            @colors=Hash["confirmed"=>"blue","taked"=> "#31B404","sended"=>"green"]

else 
  redirect_to root_path
end
end

def all_orders
      if(current_user!=nil )
        @exist=!params[:status].blank?||!params[:address].blank? || !params[:client].blank? || !params[:from].blank? || !params[:date_to].blank? || !params[:status].blank?
        if(params[:status].blank?)
          params[:status]="2"
        end
        if(params[:status].to_i>3)
          params[:status]="1"
        end
        if(current_user.rol=="admin")
          @d=Deliver.all
        elsif(current_user.rol=="regular")
          @d=current_user.delivers
        end
        @filter_deliveries=filter_deliveries(@d.order('updated_at DESC'),params[:address],params[:client],params[:status],params[:from],params[:to],current_user.rol)
        @deliveries=Kaminari.paginate_array(@filtered_deliveries).page(params[:page]).per(5)
        else 
          redirect_to root_path
        end
  end
 def remove_user_request
    if(current_user!=nil && current_user.rol=="admin")
      @orders=[]
       @shippings=[]
      if(!params[:id].blank?)
           @orders=Order.where(:id=>(params[:id].to_i(36)/87654))
          
           if(!@orders.blank?)
            @order=@orders.first
            @deliver=@order.deliver
            @shippings=filter_shippings(@deliver.shippings,@order.id)
          else
            redirect_to '/orders/remove_user_request'
            end
         end
        else 
          redirect_to root_path
        end
end
def confirm_order_send
 @deliver=Deliver.find(params[:id])
 @deliver.messenger_id=params[:messenger]
@deliver.delivery=params[:entrega]
@deliver.status="confirmed"
@deliver.save
redirect_to '/orders/all_orders'
end
def confirm
  @my_orders=params[:pedir].to_a
  if(@my_orders.size>0)
  @deliver=Deliver.new
  @deliver.user_id=current_user.id
  @deliver.location_id=params[:location].to_s
  @deliver.save
  @my_orders.each do |order|
    o=Order.find(order.to_s)
    if(o.user_id==current_user.id)
    o.deliver_id=@deliver.id
    o.save
    end
  end
  flash[:alert]="Se realizo el pedido correctamente"
    redirect_to '/orders/my_orders'
  else
    flash[:alert]="Seleccione por lo menos un producto"
    redirect_to '/orders/my_orders'
  end
end

  def view_order

  
  if(current_user!=nil && current_user.rol=="admin")
    @delivery=Deliver.find(params[:id])
    @location=@delivery.location
  @orders=@delivery.orders
   #@locations=Kaminari.paginate_array(get_locations(@orders.select(:location_id).uniq)).page(params[:page]).per(1)
 else 
  redirect_to root_path
  end

  end
  

:private
def get_locations(location_ids)
  @locations=[]
  location_ids.each do |order|
    l=Location.find(order.deliver.location_id)
    @locations<<l
  end
  @locations
end

def filter_orders(orders,name,brand,from,to)
  @filtered_orders=[]
  orders.each do |order|
    if(order.filter(name,brand,from,to))
      @filtered_orders.push(order)
    end 
  end
  @filtered_orders
end
def get_shippings(deliveries,id)
@s=[]
  deliveries.each do |delivery|
    if(id==nil || delivery.id==id.to_i)
      delivery.shippings.each do |shipping|
    @s.push(shipping)
  end
    end
  end
  @s
end
def filter_shippings(shippings,id)
  result=[]
  shippings.each do |shipping|
    if(shipping.packages.where(:order_id=>id).size>0)
      result<<shipping
    end
  end
  result
end
def filter_my_shippings(shippings,address,status,from,to,messenger,rol)
  @filtered_shippings=[]
  shippings.each do |shipping|
    if(shipping.filter_my_shipping(address,status,from,to,messenger,rol))
      @filtered_shippings.push(shipping)
    end 
  end
  @filtered_shippings
end
def filter_all_shippings(shippings,address,status,client,from,to,messenger,rol)
  @filtered_shippings=[]
  shippings.each do |shipping|
    if(shipping.filter(address,client,status,from,to,messenger,rol))
      @filtered_shippings.push(shipping)
    end 
  end
  @filtered_shippings
end
def filter_order(orders,date)
  @f_orders=[]
  orders.each do |order|
    if(order.updated_at.to_date<=date.to_date)
      @f_orders<<order
    end
  end
  @f_orders
end
 
def filter_deliveries(deliveries,address,client,status,from,to,rol)
  @filtered_deliveries=[]
  deliveries.each do |delivery|
    if(delivery.filter(address,client,status,from,to,rol))
      @filtered_deliveries.push(delivery)
    end 
  end
  @filtered_deliveries
end
end