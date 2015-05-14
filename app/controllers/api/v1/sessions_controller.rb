class Api::V1::SessionsController < Api::V1::BaseController
	include Authenticable
	before_action :authenticate, only: [:destroy]

	def create
		user_email = params[:email]
		user_password = params[:password]
		user = User.find_by(email: user_email)

		if user and user.valid_password? (user_password) then
			sign_in user, store: false
			render json: user, status: 201
		else
			render json: {errors: "Invalid email or password"}, status: 422
		end
	end

	def destroy
		current_user.generate_auth_token
		current_user.save
		head 204
	end
end