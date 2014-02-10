require 'spec_helper'

describe GadgetsController do
  render_views

  let(:user) {FactoryGirl.create :user}

  describe 'GET #index' do
    it 'should be not possible to see list of gadgets for unregistered users' do
      get :index

      expect(response).to redirect_to new_user_session_path
    end

    context 'for registered user' do
      before :each do
        another_user = FactoryGirl.create :user

        3.times {FactoryGirl.create :gadget, user_id: user.id}
        2.times {FactoryGirl.create :gadget, user_id: another_user.id}

        sign_in user
      end

      it 'should be possible to see only own list of gadgets' do
        get :index

        expect(response).to be_ok
        assigns[:gadgets].each {|gadget| expect(gadget.user_id).to eq user.id}
      end

      it 'should display list of gadgets in cover flow mode if mode is not defined' do
        get :index

        expect(response).to be_ok
        expect(response.body).to match(/<div class="gadget_cover_flow">/)
      end

      it 'should display list of gadgets in cover flow mode' do
        get :index, mode: 'cover_flow'
        
        expect(response).to be_ok
        expect(response.body).to match(/<div class="gadget_cover_flow">/)
      end

      it 'should display list of gadgets in list mode' do
        get :index, mode: 'list_mode'
        
        expect(response).to be_ok
        expect(response.body).to match(/<div class="gadget_list_mode">/)
      end
    end
  end
end
