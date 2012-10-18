class CartItem < ActiveRecord::Base
  attr_accessible :item_id, :cart_id
  belongs_to :item
  belongs_to :cart
end
