require 'rspec'
require 'spec_helper'

describe Item do

  it{ should allow_mass_assignment_of :title}
  it{ should allow_mass_assignment_of :description}
  it{ should allow_mass_assignment_of :price}

  it "should add slug to item before saving" do
    item = Item.create(:title => 'abc', :description => "description", :price => '123')
    item.slug.should == 'abc'
  end

end
