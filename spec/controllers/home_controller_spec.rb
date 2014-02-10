require 'spec_helper'

describe HomeController do
  render_views

  let(:user) {FactoryGirl.create :user}
  
  describe 'GET #index' do
    it 'should render home page for unregistered user' do
      get :index

      expect(response).to be_ok
    end

    it 'should redirect to gadgets page for registered user' do
      sign_in user
      
      get :index

      expect(response).to redirect_to user_root_path
    end
  end
end
