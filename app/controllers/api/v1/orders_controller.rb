class Api::V1::OrdersController < Api::V1::BaseController

    include Authenticable

    before_action :authenticate

    def index
        orders = Order.all

        respond_to do |format|
            format.json {render :json => orders}
        end
    end

    def show
        order = Order.find(params[:id])

        respond_to do |format|
            format.json {render :json => order}
        end
    end

    def create
        user = User.find(order_params[:user_id])
        product = Product.find(order_params[:product_id])
        amount = order_params[:amount]

        respond_to do |format|
            if (Integer(amount) > product.available)
                format.json {render :json => "There are only #{product.available} #{product.name}(s)"}
            elsif user && (user.budget < (product.price * Integer(amount)))
                format.json {render :json => "Dont have enough budget"}
            elsif user
                order = Order.new(order_params)
                user.budget = user.budget - (product.price * Integer(amount))
                if order && order.save && user.save
                    format.json {render :json => user}
                else
                    format.json {render :json => "Couldn't save user and order"}
                end
            else
                format.json {render :json => "Hubo un error"}
            end
        end
    end

    def destroy
        order = Order.find(params[:id])
        order.destroy

        respond_to do |format|
            format.json {head 204}
        end
    end

    private

    def order_params
        params.require(:order).permit(:product_id, :user_id, :amount)
    end


end
