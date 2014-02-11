require 'spec_helper'

feature 'Search for a gadget' do
  before :each do
    sign_in email: 'gadget@useruby.com', password: 'password123'
  
    FactoryGirl.create :gadget, name: 'Leica M2', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Canon 5D Mark II', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Nikon D800', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Leica M9', user_id: @user.id
  end

  scenario 'registered user make search for Leica gadget' do
    fill_in 'gadget_filter', with: 'leica'

    click_on 'Search'

    expect(body).to have_content 'Leica'
    expect(body).to_not have_content 'Canon'
    expect(body).to_not have_content 'Nikon'
  end
end
 
