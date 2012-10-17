class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation
end
