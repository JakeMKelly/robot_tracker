require 'rails_helper'
include SessionHelper

RSpec.feature "Robots", type: :feature do
  let!(:user) {User.create(username: 'test', email: 'test@gmail.com', password: 'password', admin: true)}
  let!(:manufacturer) {Manufacturer.create!(name: "LKDVDLnjldksjldskj")}
  let!(:model) {Model.create!(model_designation: "RX113", manufacturer_id: manufacturer.id, price: "$500.00")}
  let!(:robot) {Robot.create!(designation: "HAL", inventory: false, model_id: model.id, user_id: user.id )}

  before :each do
    user = create(:user)
    page.set_rack_session(:user_id => user.id)
  end

  context "logged-in user" do
    scenario "can view the details of any robot" do

      visit '/robots'

      click_on("HAL")
      within(".jumbotron") do
        expect(page).to have_content("Robot")
        expect(page).to have_content("Designation")
      end
    end
  end
end
