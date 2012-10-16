require 'rspec'
require 'spec_helper'

describe Item do

  it "should save item when parameters are passed" do
    item = Item.create(:title => 'abc', :description => "description", :price => '123')
    item.should_not be_nil
    item.id.should_not be_nil
  end

end
