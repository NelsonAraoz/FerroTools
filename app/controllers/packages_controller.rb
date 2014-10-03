class PackagesController < ApplicationController
   skip_before_filter :verify_authenticity_token
def create
  if(params[:package][:amount].to_i>0)
@shipping=Shipping.find(params[:shipping_id])
@order=Order.find(params[:order_id])
@packages=@shipping.packages.where(:order_id=>@order.id)
@total=@order.packages.sum(:amount)
@verify=@shipping.deliver.orders.where(:id=>@order.id).size>0
if(@verify)
if(@packages.size>0)
  @package=@packages.first
  @total=@total-@package.amount
  @package.amount=params[:package][:amount]
else
  @package=@shipping.packages.new(package_params)
end
if(@total+@package.amount<=@order.amount)
@package.order_id=@order.id
@package.save
else
flash[:error]="se exedio la cantidad"
end
redirect_to '/shippings/edit/'+@shipping.id.to_s
else
  redirect_to root_path
end
else
flash[:error]="cantidad mayor a 0"
redirect_to :back
end
end
def remove
  @package=Package.find(params[:id])
  @shipping=@package.shipping
  @package.destroy
  redirect_to '/shippings/edit/'+@shipping.id.to_s
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:amount)
    end
end
