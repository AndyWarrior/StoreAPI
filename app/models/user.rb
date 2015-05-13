class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, presence: true, uniqueness: true

  before_validation :generate_authentication_token!

  def generate_authentication_token!
  	begin
  		self.auth_token = Devise.friendly_token
  	end while User.exists?(auth_token: self.auth_token)
  end 
end
