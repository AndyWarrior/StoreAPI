class Api::V1::ProductsController < Api::V1::BaseController
	
	include Authenticable
	
	before_action :authenticate
	
	def index
		products = Product.all

		respond_to do |format|
			format.json {render :json => products}
		end
	end

	def show
		product = Product.find(params[:id])
		
		respond_to do |format|
			format.json {render :json => product}
		end
	end

	def create
		product = Product.new(product_params)
		
		respond_to do |format|
			if product.save
				format.json {render :json => product}
			else
				format.json {render :json => "Hubo un error"}
			end
		end
	end

	def update
		product = Product.find(params[:id])
		
		respond_to do |format|
			if product.update(product_params)
				format.json {render :json => product}
			else
				format.json {render :json => "Hubo un error"}
			end
		end
	end

	def destroy
		product = Product.find(params[:id])
		product.destroy
		
		respond_to do |format|
			format.json {head 204}
		end
	end

	private

	def product_params
		params.require(:product).permit(:name, :description, :price, :image_url, :available)
	end

end
