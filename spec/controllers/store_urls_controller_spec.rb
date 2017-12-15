require 'rails_helper'

describe StoreUrlsController do

  shared_examples 'ログイン不要なアクセス' do
    describe "GET #index" do
      before do
        @store_url1 = create(:store_url)
        @store_url2 = create(:store_url)
        @store_url3 = create(:store_url)
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_success
      end

      it 'assigns all store_urls' do
        expect(assigns(:store_urls)).to include @store_url1, @store_url2, @store_url3
      end
    end

    describe "GET #show" do
      before do
        @store_url = create(:store_url)
      end
      context '存在する場合' do
        before do
          get :show, params: {id: @store_url.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns store_url' do
          expect(assigns(:store_url)).to eq @store_url
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
  end

  shared_examples '非ログインのアクセス' do

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
        @store_url = create(:store_url)
        get :edit, params: {id: @store_url.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {store_url: build(:store_url).attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      before do
        create(:store_url)
        create(:store_url)
        @store_url = create(:store_url)
        put :update, params: {id: @store_url.id, store_url: @store_url.attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      before do
        @store_url = create(:store_url)
        delete :destroy, params: {id: @store_url.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  shared_examples '一般ユーザーのアクセス' do

    describe "GET #new" do
      before do
        get :new
      end
      it "returns a success response" do
        expect(response).to be_success
      end
      it "assigns new store_url" do
        expect(assigns(:store_url)).to be_a_new(StoreUrl)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new StoreUrl" do
          expect {
            post :create, params: {store_url: build(:store_url).attributes}
          }.to change(StoreUrl, :count).by(1)
        end

        it "redirects to the created store_url" do
          post :create, params: {store_url: build(:store_url).attributes}
          expect(response).to redirect_to(StoreUrl.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {store_url: build(:invalid_store_url).attributes}
          expect(response).to be_success
        end
      end
    end

    describe "自分のゲーム" do
      before do
        mygame = create(:game, user: @logged_in_user)
        create(:store_url)
        @store_url = create(:store_url, game: mygame)
        create(:store_url)
      end

      describe "GET #edit" do
        context '存在する場合' do
          before do
            get :edit, params: {id: @store_url.id}
          end
          it 'returns a success response' do
            expect(response).to be_success
          end
          it 'assigns store_url' do
            expect(assigns(:store_url)).to eq @store_url
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

      describe "PUT #update" do
        context "with valid params" do
          before do
            @store_url.url = 'https://hoge.com/new_url'
          end

          let(:put_store_url) {-> {put :update, params: {id: @store_url.id, store_url: @store_url.attributes}}}

          it "don't creates a new StoreUrl" do
            expect {
              put_store_url.call
            }.to change(StoreUrl, :count).by(0)
          end

          it '正常に更新されること' do
            put_store_url.call
            @store_url.reload
            expect(@store_url.url).to eq 'https://hoge.com/new_url'
          end

          it "redirects to the store_url" do
            put_store_url.call
            expect(response).to redirect_to(@store_url)
          end
        end

        context "with invalid params" do
          before do
            @store_url.url = '    '
          end

          let(:put_store_url) {-> {put :update, params: {id: @store_url.id, store_url: @store_url.attributes}}}

          it "returns a success response (i.e. to display the 'edit' template)" do
            put_store_url.call
            expect(response).to be_success
          end

        end

      end

      describe "DELETE #destroy" do
        let(:delete_store_url) {-> {delete :destroy, params: {id: @store_url.id}}}

        it "destroys the requested store_url" do
          expect {
            delete_store_url.call
          }.to change(StoreUrl, :count).by(-1)
        end

        it "redirects to the categories list" do
          delete_store_url.call
          expect(response).to redirect_to(store_urls_url)
        end
      end
    end

    describe "他人のゲーム" do
      before do
        create(:store_url)
        @store_url = create(:store_url)
        create(:store_url)
      end

      describe "GET #edit" do
        context '存在する場合' do
          before do
            get :edit, params: {id: @store_url.id}
          end
          it '403になること' do
            expect(response).to have_http_status(:forbidden)
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

      describe "PUT #update" do
        context "with valid params" do
          before do
            @store_url.url = 'https://hoge.com/new_url'
            put :update, params: {id: @store_url.id, store_url: @store_url.attributes}
          end
          it '403になること' do
            expect(response).to have_http_status(:forbidden)
          end
        end

        context "with invalid params" do
          before do
            @store_url.url = '    '
            put :update, params: {id: @store_url.id, store_url: @store_url.attributes}
          end
          it '403になること' do
            expect(response).to have_http_status(:forbidden)
          end
        end

      end

      describe "DELETE #destroy" do
        before do
          delete :destroy, params: {id: @store_url.id}
        end
        it '403になること' do
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

  end


  describe 'ゲストユーザーによるアクセス' do
    it_behaves_like 'ログイン不要なアクセス'
    it_behaves_like '非ログインのアクセス'
  end

  describe '一般ユーザーによるアクセス' do
    before do
      @logged_in_user = build(:user)
      @logged_in_user.skip_confirmation!
      @logged_in_user.save
      sign_in @logged_in_user
    end
    it_behaves_like 'ログイン不要なアクセス'
    it_behaves_like '一般ユーザーのアクセス'
  end

end
