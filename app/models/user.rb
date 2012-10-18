class User < ActiveRecord::Base
  has_one :cart
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
end
