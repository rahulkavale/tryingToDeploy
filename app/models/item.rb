class Item < ActiveRecord::Base
  attr_accessible :description, :price, :title
  before_save :create_slug

  def create_slug
    self.slug = self.title.parameterize
  end
end
