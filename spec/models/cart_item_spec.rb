require 'rspec'
require 'spec_helper'

describe CartItem do

  it{ should allow_mass_assignment_of :item_id}
  it{ should allow_mass_assignment_of :cart_id}

end
