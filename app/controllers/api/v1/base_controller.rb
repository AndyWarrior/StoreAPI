class Api::V1::BaseController < ApplicationController
	include 'Authenticable'
	
	protect_from_forgery with: :null_session
end