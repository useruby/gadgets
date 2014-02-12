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
        FactoryGirl.create :gadget, name: 'Leica M2', user_id: user.id

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
        expect(response.body).to match(/<li class="thumbnail gadget_cover_flow">/)
      end

      it 'should display list of gadgets in cover flow mode' do
        get :index, mode: 'cover_flow'
        
        expect(response).to be_ok
        expect(response.body).to match(/<li class="thumbnail gadget_cover_flow">/)
      end

      it 'should display list of gadgets in list mode' do
        get :index, mode: 'list_mode'
        
        expect(response).to be_ok
        expect(response.body).to match(/<li class="gadget_list_mode">/)
      end

      it 'should display list of gadgets with name start with Leica' do
        get :index, gadget: {filter: 'Leica'}

        expect(response).to be_ok
        assigns[:gadgets].each {|gadget| expect(gadget.name).to be_start_with 'Leica'}
      end

      it 'should display all the gadgets that user have if filter is not set' do
        get :index

        expect(response).to be_ok
        expect(assigns[:gadgets].size).to eq 4
      end
    end
  end

  describe 'GET #new' do
    it 'should display form for creating a new gadget' do
      sign_in user

      get :new

      expect(response).to be_ok
    end
  end

  describe 'POST #create' do
    it 'should add a new gadget' do
      sign_in user

      expect{
        post :create, gadget: {name: 'Raspberry PI', description: 'small and cheap computer'}
      }.to change(Gadget, :count).by(1)
    end

    it 'should redirect to list of gadget page after create' do
      sign_in user

      post :create, gadget: {name: 'Raspberry PI', description: 'small and cheap computer'}
      
      expect(response).to redirect_to gadgets_path
    end

    it 'should not be possible to create new gadget if name is not set' do
      sign_in user

      expect{
        post :create, gadget: {name: '', description: 'description for gadget'}
      }.to_not change(Gadget, :count).by(1)
    end

    it 'should display new gadget form with error if gadget is not created' do
      sign_in user

      post :create, gadget: {name: '', description: 'description for gadget'}

      expect(response).to render_template :new
      expect(response.body).to match(/can't be blank/)
    end

    it 'should create new gadget and attach image to it' do
      sign_in user

      gadget_image = fixture_file_upload('spec/fixtures/images/leica_m2.jpg', 'image/jpeg')
   
      post :create, gadget: {name: 'Leica M2', image: gadget_image}
    
      expect(user.gadgets.last.image.url).to be_end_with 'leica_m2.jpg'
    end
  end
end
