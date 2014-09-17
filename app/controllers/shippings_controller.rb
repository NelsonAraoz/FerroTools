class ShippingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout 'categories'
  def index
    if(current_user!=nil && current_user.rol=="admin")
    @deliver=Deliver.find(params[:id])
     @status=Hash["confirmed"=>"Confirmado","taked"=> "En camino","sended"=>"Enviado","pending"=>"Pendiente"]
    @shippings=@deliver.shippings
  else
    redirect_to root_path
  end
  end
  def new
    @deliver=Deliver.find(params[:id])
    @shipping=@deliver.shippings
    @location=@deliver.location
    @orders=@deliver.orders
  end
  def create
    if(current_user!=nil && current_user.rol=="admin")
    @delivery=Deliver.find(params[:id])
    if(!@delivery.is_complete(current_user.rol))
    @shipping=@delivery.shippings.new
    @shipping.save
    redirect_to '/shippings/edit/'+@shipping.id.to_s
    else
      flash[:alert]="Este pedido ya esta completo"
      redirect_to :back
    end
  else
    redirect_to root_path
  end
  end
  def show
     @shipping=Shipping.find(params[:id])
     @packages=@shipping.packages
     @location=@shipping.deliver.location
  end
  def edit
      if(current_user!=nil && current_user.rol=="admin")
  
    @shipping=Shipping.find(params[:id])
    @deliver=@shipping.deliver
     @location=@deliver.location
     @packages=@shipping.packages
    @orders=@deliver.orders
     else
    redirect_to root_path
  end
  end
  def update_shipping_send
    @my_orders=params[:llevar].to_a
    @shipping=Shipping.find(params[:id])
   @my_orders.each do |order|
    o=Order.find(order.to_s)
    o.shipping_id=@shipping.id
    o.save
  end
   flash[:alert]="Pedido programado correctamente"
    redirect_to root_path
  
  end
  def edit_data
    @shipping=Shipping.find(params[:id])
  end
  def update_data
     @shipping=Shipping.find(params[:id])
     @shipping.delivery=params[:entrega]
     @shipping.messenger_id=params[:messenger]
     if @shipping.save
      flash[:alert]="Pedido actualizado correctamente"
      redirect_to '/shippings/index/'+@shipping.deliver.id.to_s
     else
      flash[:alert]="error"
     end
  end
  def confirm
    @shipping=Shipping.find(params[:id])
    if(@shipping.status=='pending')
      if(@shipping.messenger!=nil && !@shipping.delivery.blank? )  
      @shipping.status='confirmed'
      @shipping.save
      flash[:alert]="Envio confirmado"
       redirect_to '/shippings/show/'+@shipping.id.to_s
     else
           flash[:alert]="Se debe asignar un mensajero"
          redirect_to :back
     end
    else
      flash[:alert]="Envio ya estaba confirmado"
      redirect_to '/shippings/show'+@shipping.id.to_s
    end
  end
  def confirm_shipping_send
   @errors=[]
   @my_orders=params[:llevar].to_a
   @amounts=params[:cantidad].to_a
   if(@amounts.size==0 || @my_orders.size==0 || @amounts.size!=@my_orders.size)
      flash[:error]="debe seleccionar por lo menos un producto"
   else
   @deliver=Deliver.find(params[:id])
   @shipping=@deliver.shippings.new(shipping_params)
   @shipping.status="confirmed"
   @shipping.save
   @my_orders.each_with_index do |order,index|

    o=Order.find(order.to_s)
  if((@amounts[index].is_a? Integer) &&o.amount-o.packages.sum(:amount)>=@amounts[index]  && amounts[index]>0)    
    @package=Package.new({:shipping_id=>@shipping.id,:amount=>@amounts[index],:order_id=>o.id})
    @package.save
  else
      @errors<<"revisar"
  end
  end
  if(@errors.size>0)
    redirect_to :back
  else
   flash[:alert]="Pedido programado correctamente"
    redirect_to root_path
  end
  end
  end
  def remove
    @shipping=Shipping.find(params[:id])
    @orders=@shipping.orders
  end

  def edit_status
    if(current_user!=nil && current_user.rol=='admin')
      @status=params[:my_status]
      if(@status=='pending' || @status=='confirmed' ||@status=='taked' ||@status=='sended' )
        @shipping=Shipping.find(params[:id])
        if(@shipping.messenger!=nil && !@shipping.delivery.blank? && @shipping.packages.size>0)
        @shipping.status=@status
        @shipping.save
        redirect_to :back
        else
          flash[:alert]="Se debe asignar un mensajero y por lo menos un producto"
          redirect_to :back
        end
    else
    redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def destroy

  if(current_user!=nil && current_user.rol=='admin')
    @shipping=Shipping.find(params[:id])
    @deliver_id=@shipping.deliver_id
    if(@shipping.status=='pending' || @shipping.status=='confirmed')
    @shipping.packages.each do |package|
        package.destroy
    end
    @shipping.destroy
    redirect_to '/delivers/show/'+@deliver_id.to_s
  else
    flash[:alert]="Pedido en ejecucion!"
    redirect_to root_path
  end
  else
    redirect_to root_path
  end

  end
#services
def get_shippings
  @shippings=Shipping.where(:messenger_id=>params[:id],:status=>'ready')

  render json: @shippings
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_params
      params.require(:shipping).permit(:status,:delivery,:messenger_id,:deliver_id)
    end
    def sumar(shippings,id)
      suma=0
      shippings.each do |shipping|
        suma=suma+shipping.packages.where(:order_id=>id).sum(:amount)
      end
      suma
    end
    def is_complete(shippings,orders)
      orders.each do |order|
        @total=sumar(shippings,order.id)
        if(@total<order.amount)
          return false
        end
      end
      true
    end
end
