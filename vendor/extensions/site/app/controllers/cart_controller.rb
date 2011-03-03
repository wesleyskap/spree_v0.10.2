class CartController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def checkout
    # Busca o pedido associado ao usuário; esta lógica deve
    # ser implementada por você, da maneira que achar melhor
    @invoice = current_user.invoices.last

    # Instanciando o objeto para geração do formulário
    @order = PagSeguro::Order.new(@invoice.id)

    # adicionando os produtos do pedido ao objeto do formulário
    @invoice.products.each do |product|
      # Estes são os atributos necessários. Por padrão, peso (:weight) é definido para 0,
      # quantidade é definido como 1 e frete (:shipping) é definido como 0.
      @order.add :id => product.id, :price => product.price, :description => product.title
    end
   
  end
  

  def confirm
    return unless request.post?
    
    # Se você receber pagamentos de contas diferentes, pode passar o
    # authenticity_token adequado como parâmetro para pagseguro_notification
    account = Account.find(params[:seller_id])
    pagseguro_notification(account.authenticity_token) do |notification|
      # Aqui você deve verificar se o pedido possui os mesmos produtos
      # que você cadastrou. O produto só deve ser liberado caso o status
      # do pedido seja "completed" ou "approved"
      
    end

    render :nothing => true
  end
end