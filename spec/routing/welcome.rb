require 'rails_helper'

RSpec.describe "Routing from welcome", type: :routing do

  it 'routes get / to welcome#index' do
    expect(get: "/").to route_to("welcome#index")
  end
end
