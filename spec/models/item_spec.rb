require 'rspec'
require 'spec_helper'

describe Item do

  it{ should allow_mass_assignment_of :title}
  it{ should allow_mass_assignment_of :description}
  it{ should allow_mass_assignment_of :price}

end
