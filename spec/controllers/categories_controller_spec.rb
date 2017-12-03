require 'rails_helper'

describe CategoriesController do


  shared_examples '非ログインのアクセス' do
    describe "GET #index" do
      before do
        create(:category)
        get :index
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #show" do
      before do
        @cat = create(:category)
        get :show, params: {id: @cat.id}
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
        @cat = create(:category)
        get :edit, params: {id: @cat.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {category: build(:category).attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      before do
        create(:category)
        create(:category)
        @cat = create(:category)
        put :update, params: {id: @cat.id, category: @cat.attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      before do
        @cat = create(:category)
        delete :destroy, params: {id: @cat.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  shared_examples '一般ユーザーのアクセス' do
    describe "GET #index" do
      before do
        create(:category)
        get :index
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "GET #show" do
      before do
        @cat = create(:category)
        get :show, params: {id: @cat.id}
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
        @cat = create(:category)
        get :edit, params: {id: @cat.id}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {category: build(:category).attributes}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "PUT #update" do
      before do
        create(:category)
        create(:category)
        @cat = create(:category)
        put :update, params: {id: @cat.id, category: @cat.attributes}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "DELETE #destroy" do
      before do
        @cat = create(:category)
        delete :destroy, params: {id: @cat.id}
      end
      it '403になること' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  shared_examples '管理者のアクセス' do
    describe "GET #index" do
      before do
        @cat1 = create(:category)
        @cat2 = create(:category)
        @cat3 = create(:category)
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_success
      end

      it 'assigns all categories' do
        expect(assigns(:categories)).to include @cat1, @cat2, @cat3
      end
    end

    describe "GET #show" do
      before do
        @cat = create(:category)
      end
      context '存在する場合' do
        before do
          get :show, params: {id: @cat.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns category' do
          expect(assigns(:category)).to eq @cat
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
      it "assigns new category" do
        expect(assigns(:category)).to be_a_new(Category)
      end
    end

    describe "GET #edit" do
      before do
        @cat = create(:category)
      end
      context '存在する場合' do
        before do
          get :edit, params: {id: @cat.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns category' do
          expect(assigns(:category)).to eq @cat
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
        it "creates a new Category" do
          expect {
            post :create, params: {category: build(:category).attributes}
          }.to change(Category, :count).by(1)
        end

        it "redirects to the created category" do
          post :create, params: {category: build(:category).attributes}
          expect(response).to redirect_to(Category.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {category: build(:invalid_category).attributes}
          expect(response).to be_success
        end
      end
    end

    describe "PUT #update" do
      before do
        create(:category)
        @cat = create(:category)
        create(:category)
      end

      context "with valid params" do
        before do
          @cat.name = '新カテゴリー'
        end

        let(:put_category) {-> {put :update, params: {id: @cat.id, category: @cat.attributes}}}

        it "don't creates a new Category" do
          expect {
            put_category.call
          }.to change(Category, :count).by(0)
        end

        it '正常に更新されること' do
          put_category.call
          @cat.reload
          expect(@cat.name).to eq '新カテゴリー'
        end

        it "redirects to the category" do
          put_category.call
          expect(response).to redirect_to(@cat)
        end
      end

      context "with invalid params" do
        before do
          @cat.name = '    '
        end

        let(:put_category) {-> {put :update, params: {id: @cat.id, category: @cat.attributes}}}

        it "returns a success response (i.e. to display the 'edit' template)" do
          put_category.call
          expect(response).to be_success
        end

      end

    end

    describe "DELETE #destroy" do
      before do
        create(:category)
        @cat = create(:category)
        create(:category)
      end

      let(:delete_category) {-> {delete :destroy, params: {id: @cat.id}}}

      it "destroys the requested category" do
        expect {
          delete_category.call
        }.to change(Category, :count).by(-1)
      end

      it "redirects to the categories list" do
        delete_category.call
        expect(response).to redirect_to(categories_url)
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
