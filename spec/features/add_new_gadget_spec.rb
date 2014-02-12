require 'spec_helper'

feature 'Add new gadget' do
  before :each do
    sign_in email: 'gadget@useruby.com', password: 'password123'
    click_on 'Add new gadget'
    
    expect(current_path).to eq new_gadget_path
  end

  scenario 'registered user adding new gadget' do
    fill_in 'gadget_name', with: 'Super Gadget'
    click_on 'Add new gadget'

    expect(current_path).to eq gadgets_path

    expect(body).to have_content 'Super Gadget'
  end

  scenario 'registered user adding new gadget and attaching image to it' do
    fill_in 'gadget_name', with: 'Super Gadget'
    attach_file 'gadget_image', 'spec/fixtures/images/leica_m2.jpg'
    
    click_on 'Add new gadget'

    expect(current_path).to eq gadgets_path

    expect(body).to have_selector 'img[alt="Thumb_leica_m2"]'
  end

  scenario 'registered user haven\'t filled the name fild when adding new gadget' do
    click_on 'Add new gadget'

    expect(current_path).to eq gadgets_path

    expect(body).to have_selector 'div.error.gadget_name'
  end
end
