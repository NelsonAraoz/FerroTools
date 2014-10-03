class Message < ActionMailer::Base
  default from: "no-reply@ferro-tools.com"
   def shipping_programmed(shipping,status)
    @shipping=shipping
    @status=status
    @user = @shipping.deliver.user
    @delivery=@shipping.deliver
    #@url  = 'http://localhost:3000/usuarios/confirm?pass='+AESCrypt.encrypt(@user.id.to_s,"Taller")

    @url  = 'http://127.0.0.1:3000/delivers/show/'+@delivery.id.to_s #AESCrypt.encrypt(@user.id.to_s,"Taller")
    mail(to: @user.email, subject: 'Envio de productos')
  end
end
