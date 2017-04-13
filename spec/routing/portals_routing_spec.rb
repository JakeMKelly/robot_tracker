require 'rails_helper'

RSpec.describe "Routing to portals", type: :routing do

  it 'routes get /open to portals#open' do
    expect(get: "/open").to route_to("portals#open")
  end

  it 'routes get /closed to portals#closed' do
    expect(get: "/closed").to route_to("portals#closed")
  end
end
