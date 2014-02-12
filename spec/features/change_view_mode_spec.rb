require 'spec_helper'

feature 'Change view mode for list of gadgets' do
  before :each do
    sign_in email: 'gadget@useruby.com', password: 'password123'
  
    FactoryGirl.create :gadget, name: 'Leica M2', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Canon 5D Mark II', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Nikon D800', user_id: @user.id
    FactoryGirl.create :gadget, name: 'Leica M9', user_id: @user.id
  end

  scenario 'registered user change mode from cover flow to list mode' do
    click_on 'List Mode'

    expect(body).to have_selector 'span.active[text()="List Mode"]'
    expect(body).to_not have_selector 'img[alt="Thumb_blank_gadget"]'
  end

  scenario 'registered user change mode from list mode to cover flow' do
    click_on 'List Mode'
    click_on 'Cover Flow'

    expect(body).to have_selector 'span.active[text()="Cover Flow"]'
    expect(body).to have_selector 'img[alt="Thumb blank gadget"]'
  end
end

