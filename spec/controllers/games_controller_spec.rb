require 'rails_helper'

describe GamesController do

  shared_examples 'ログイン不要なアクセス' do
    describe "GET #index" do
      before do
        get :index
      end

      it 'returns a success response' do
        expect(response).to be_success
      end
    end

    describe "GET #show" do
      before do
        @game = create(:game)
      end
      context '存在する場合' do
        before do
          get :show, params: {id: @game.id}
        end
        it 'returns a success response' do
          expect(response).to be_success
        end
        it 'assigns game' do
          expect(assigns(:game)).to eq @game
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
        @game = create(:game)
        get :edit, params: {id: @game.id}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      before do
        post :create, params: {game: build(:game).attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      before do
        create(:game)
        create(:game)
        @game = create(:game)
        put :update, params: {id: @game.id, game: @game.attributes}
      end
      it 'ログイン画面にリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      before do
        @game = create(:game)
        delete :destroy, params: {id: @game.id}
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
      it "assigns new game" do
        expect(assigns(:game)).to be_a_new(Game)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Game" do
          expect {
            post :create, params: {game: build(:game).attributes}
          }.to change(Game, :count).by(1)
        end

        it "redirects to the created game" do
          post :create, params: {game: build(:game).attributes}
          expect(response).to redirect_to(Game.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {game: build(:invalid_game).attributes}
          expect(assigns(:recent_tags)).not_to be_nil
          expect(response).to be_success
        end
      end
    end

    describe "自分のゲーム" do
      before do
        create(:game)
        @game = create(:game, user: @logged_in_user)
        create(:game)
      end

      describe "GET #edit" do
        context '存在する場合' do
          before do
            get :edit, params: {id: @game.id}
          end
          it 'returns a success response' do
            expect(response).to be_success
          end
          it 'assigns game' do
            expect(assigns(:game)).to eq @game
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
            @game.title = 'とてもおもしろそうな新タイトル'
          end

          let(:put_game) {-> {put :update, params: {id: @game.id, game: @game.attributes}}}

          it "don't creates a new Game" do
            expect {
              put_game.call
            }.to change(Game, :count).by(0)
          end

          it '正常に更新されること' do
            put_game.call
            @game.reload
            expect(@game.title).to eq 'とてもおもしろそうな新タイトル'
          end

          it "redirects to the game" do
            put_game.call
            expect(response).to redirect_to(@game)
          end
        end

        context "with invalid params" do
          before do
            @game.title = '    '
          end

          let(:put_game) {-> {put :update, params: {id: @game.id, game: @game.attributes}}}

          it "returns a success response (i.e. to display the 'edit' template)" do
            put_game.call
            expect(assigns(:recent_tags)).not_to be_nil
            expect(response).to be_success
          end

        end

      end

      describe "DELETE #destroy" do
        let(:delete_game) {-> {delete :destroy, params: {id: @game.id}}}

        it "destroys the requested game" do
          expect {
            delete_game.call
          }.to change(Game, :count).by(-1)
        end

        it "redirects to the categories list" do
          delete_game.call
          expect(response).to redirect_to(games_url)
        end
      end
    end

    describe "他人のゲーム" do
      before do
        create(:game)
        @game = create(:game)
        create(:game)
      end

      describe "GET #edit" do
        context '存在する場合' do
          before do
            get :edit, params: {id: @game.id}
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
            @game.title = 'とてもおもしろそうなタイトル'
            put :update, params: {id: @game.id, game: @game.attributes}
          end
          it '403になること' do
            expect(response).to have_http_status(:forbidden)
          end
        end

        context "with invalid params" do
          before do
            @game.title = '    '
            put :update, params: {id: @game.id, game: @game.attributes}
          end
          it '403になること' do
            expect(response).to have_http_status(:forbidden)
          end
        end

      end

      describe "DELETE #destroy" do
        before do
          delete :destroy, params: {id: @game.id}
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
