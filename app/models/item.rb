class Item < ActiveRecord::Base
  has_many :cart_items
  attr_accessible :description, :price, :title
  before_save :create_slug

  def create_slug
    self.slug = self.title.parameterize
  end
end
