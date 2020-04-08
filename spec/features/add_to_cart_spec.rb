require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "See updated cart" do
    # ACT
    visit root_path
    user = User.create!(:email => 'neema8@gmail.com', :password => 'neema', :password_confirmation => 'neema', :first_name => "Neema",:last_name => "Neema")

    page.fill_in "email", with: 'neema8@gmail.com'
    page.fill_in "password", with: 'neema'
    click_on 'Submit'
    
    page.find('div.products article:first-child').click_button("Add")
    expect(page).to have_content "My Cart (1)"
    save_screenshot
    # DEBUG / VERIFY
    
  end

end
