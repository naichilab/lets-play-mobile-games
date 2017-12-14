require 'rails_helper'

describe PlatformsController do

  shared_examples '非ログインのアクセス' do
    describe "GET #index" do
      before do
        create(:platform)
        get :index
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #show" do
      before do
        @platform = create(:platform)
        get :show, params: {id: @platform.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #new" do
      before do
        get :new
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #edit" do
      before do
        @platform = create(:platform)
        get :edit, params: {id: @platform.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {platform: build(:platform).attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      before do
        create(:platform)
        create(:platform)
        @platform = create(:platform)
        put :update, params: {id: @platform.id, platform: @platform.attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      before do
        @platform = create(:platform)
        delete :destroy, params: {id: @platform.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  shared_examples '一般ユーザーのアクセス' do
    describe "GET #index" do
      before do
        create(:platform)
        get :index
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "GET #show" do
      before do
        @platform = create(:platform)
        get :show, params: {id: @platform.id}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "GET #new" do
      before do
        get :new
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "GET #edit" do
      before do
        @platform = create(:platform)
        get :edit, params: {id: @platform.id}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {platform: build(:platform).attributes}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "PUT #update" do
      before do
        create(:platform)
        create(:platform)
        @platform = create(:platform)
        put :update, params: {id: @platform.id, platform: @platform.attributes}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "DELETE #destroy" do
      before do
        @platform = create(:platform)
        delete :destroy, params: {id: @platform.id}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  shared_examples '管理者のアクセス' do
    describe "GET #index" do
      before do
        @platform1 = create(:platform)
        @platform2 = create(:platform)
        @platform3 = create(:platform)
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_success
      end

      it 'assigns all platforms' do
        expect(assigns(:platforms)).to include @platform1, @platform2, @platform3
      end
    end

    describe "GET #show" do
      before do
        @platform = create(:platform)
      end
      context '存在する場合' do
        before do
          get :show, params: {id: @platform.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns platform' do
          expect(assigns(:platform)).to eq @platform
        end
        it 'displays show template' do
          expect(response).to render_template :show
        end
      end
      context '存在しない場合' do
        it 'raise RecordNotFound' do
          expect {
            get :show, params: {id: 12345}
          }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end

    end

    describe "GET #new" do
      before do
        get :new
      end
      it "returns a success response" do
        expect(response).to be_success
      end
      it "assigns new platform" do
        expect(assigns(:platform)).to be_a_new(Platform)
      end
    end

    describe "GET #edit" do
      before do
        @platform = create(:platform)
      end
      context '存在する場合' do
        before do
          get :edit, params: {id: @platform.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns platform' do
          expect(assigns(:platform)).to eq @platform
        end
        it 'displays edit template' do
          expect(response).to render_template :edit
        end
      end
      context '存在しない場合' do
        it 'raise RecordNotFound' do
          expect {
            get :edit, params: {id: 12345}
          }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Platform" do
          expect {
            post :create, params: {platform: build(:platform).attributes}
          }.to change(Platform, :count).by(1)
        end

        it "redirects to the created platform" do
          post :create, params: {platform: build(:platform).attributes}
          expect(response).to redirect_to(Platform.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {platform: build(:invalid_platform).attributes}
          expect(response).to be_success
        end
      end
    end

    describe "PUT #update" do
      before do
        create(:platform)
        @platform = create(:platform)
        create(:platform)
      end

      context "with valid params" do
        before do
          @platform.code = "new_code"
          @platform.name = '新プラッフォトーム'
        end

        let(:put_platform) {-> {put :update, params: {id: @platform.id, platform: @platform.attributes}}}

        it "don't creates a new Platform" do
          expect {
            put_platform.call
          }.to change(Platform, :count).by(0)
        end

        it '正常に更新されること' do
          put_platform.call
          @platform.reload
          expect(@platform.code).to eq 'new_code'
          expect(@platform.name).to eq '新プラッフォトーム'
        end

        it "redirects to the platform" do
          put_platform.call
          expect(response).to redirect_to(@platform)
        end
      end

      context "with invalid params" do
        before do
          @platform.name = '    '
        end

        let(:put_platform) {-> {put :update, params: {id: @platform.id, platform: @platform.attributes}}}

        it "returns a success response (i.e. to display the 'edit' template)" do
          put_platform.call
          expect(response).to be_success
        end

      end

    end

    describe "DELETE #destroy" do
      before do
        create(:platform)
        @platform = create(:platform)
        create(:platform)
      end

      let(:delete_platform) {-> {delete :destroy, params: {id: @platform.id}}}

      it "destroys the requested platform" do
        expect {
          delete_platform.call
        }.to change(Platform, :count).by(-1)
      end

      it "redirects to the platforms list" do
        delete_platform.call
        expect(response).to redirect_to(platforms_url)
      end
    end
  end


  describe 'ゲストユーザーによるアクセス' do
    it_behaves_like '非ログインのアクセス'
  end

  describe '一般ユーザーによるアクセス' do
    before do
      user = build(:user)
      user.skip_confirmation!
      user.save
      sign_in user
    end
    it_behaves_like '一般ユーザーのアクセス'
  end

  describe '管理者ユーザーによるアクセス' do
    before do
      admin_user = build(:admin_user)
      admin_user.skip_confirmation!
      admin_user.save
      sign_in admin_user
    end
    it_behaves_like '管理者のアクセス' 
  end

end
