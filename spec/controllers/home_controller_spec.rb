require 'spec_helper'

describe HomeController do
  render_views

  describe 'GET #index' do
    it 'should render home page for unregistered user' do
      get :index

      expect(response).to be_ok
    end

    it 'should redirect to gadgets page for registered user' do
      pending 'not implemented yet'
    end
  end
end
