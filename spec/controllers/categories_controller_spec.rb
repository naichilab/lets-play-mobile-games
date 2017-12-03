require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController. Be sure to keep this updated too.
  let(:valid_session) {{}}

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
