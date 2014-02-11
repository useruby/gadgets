module Features
  module SessionHelpers
    def sign_up email: email, password: password
      visit new_user_registration_path

      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Sign up'
    end

    def sign_in email: 'foo@bar.com', password: 'foobarbaz'
      @user = FactoryGirl.create :user, email: email, password: password
      
      visit new_user_session_path
      
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      
      click_button 'Sign in'
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end

