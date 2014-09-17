class DeliversController < ApplicationController
  skip_before_filter :verify_authenticity_token
  layout 'categories'
  def show
    if(current_user!=nil)
    @deliver=Deliver.find(params[:id])
    @orders=@deliver.orders
     @status=Hash["confirmed"=>"Confirmado","taked"=> "En camino","sended"=>"Enviado","pending"=>"Pendiente"]
    if(current_user.rol=='regular')
    @shippings=@deliver.shippings.where.not(:status=>'pending')
    else
      @shippings=@deliver.shippings
    end
    @location=@deliver.location
    else
      redirect_to root_path
    end
  end
  def delete_deliver
    if(!params[:id].blank?)
    @deliver=Deliver.where(:id=>(params[:id].to_i(36)/98765))
    if(@deliver.blank?)
      @exist=false
    else
      flash[:alert]="asd"
      redirect_to '/orders/delete_items/'+@deliver.first.id.to_s
    end
  else
    @exist=true
  end
  end
  def remove_all
    if(current_user!=nil && current_user.rol=="admin")
      @delivery=Deliver.find(params[:id])
      @shippings=@delivery.shippings
      @orders=@delivery.orders
      @shippings.each do |shippings|
         if(@shipping.status=='pending' || @shipping.status=='confirmed')
            @shipping.packages.each do |package|
              package.destroy
            end
          end
      end
      @orders.each do |order|
        order.amount=order.packages.sum(:amount)
        order.save
        if(order.amount==0)
          order.destroy
        end
      end
      if(@delivery.orders.size==0)
        @delivery.destroy
        flash[:alert]="Se elimino todo el pedido"
      redirect_to "/orders/all_orders"
      else
      flash[:alert]="Los pedidos en ejecucion y enviados deben ser eliminados manualmente"
      redirect_to :back
      end
    else
      redirect_to root_path
    end
  end
  #services
  def get_deliveries
    @deliveries=Deliver.where(:messenger_id=>params[:id])
    @a=@deliveries.joins(:location).joins(:user).select('delivers.id as "delivery_id",locations.*,users.name,users.lastname,users.phone,users.email,delivers.status,delivers.delivery')
    render json: @a
  end
  def deliveries_table
    @orders=Order.where(:deliver_id=>params[:id])
     render :layout => false
  end
  def change_status
    @status=['confirmed','taked','sended']
    @delivery=Deliver.find(params[:id])
    @delivery.status=@status[params[:status].to_i]
    @delivery.save
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_deliver
     # @location = Location.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def location_params
     # params.require(:shipping).permit(:status,:delivery,:messenger_id,:deliver_id)
    #end
end
