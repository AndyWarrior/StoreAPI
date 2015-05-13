module Authenticable

	def authenticate
		current_user || render_unauthorized
	end
	
	def authenticate_with_token
		authenticate_with_http_token do |token,options|
			User.find_by(auth_token: token)
		end
	end
	
	def render_unauthorized
		self.headers['WWW-Authenticate'] = 'Token realm="Application"'
		render json: {errors: ['Unauthorized'] }, status: 401
	end
	
	def current_user
		@current_user ||= authenticate_with_http_token
	end
end