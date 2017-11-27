require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe 'GET #index' do

    let(:user_1) { create(:user) }
    let!(:post_1) { create(:post, user: user_1) }

    before do
      get :index, params: { user_id: user_1 }
    end

    it { expect(assigns(:posts)).to contain_exactly(post_1) }
    it { expect(assigns(:posts).length).to eq(1) }

  end

  describe 'GET #show' do

    let(:post_1) { create(:post) }

    before { get :show, params: { user_id: post_1.user, id: post_1 } }

    it { expect(assigns(:post)).to eq(post_1) }

  end

  describe 'GET #new' do

    let(:user_1) { create(:user) }

    before { get :new, params: { user_id: user_1 } }

    it { expect(assigns(:post)).to be_a_new(Post) }

  end

  describe 'GET #edit' do

    let(:post_1) { create(:post) }

    before { get :edit, params: { user_id: post_1.user, id: post_1 } }

    it { expect(assigns(:post)).to eq(post_1) }

  end

  describe 'POST #create' do

    let(:user_1) { create(:user) }

    before do
      post :create, params: {
        user_id: user_1,
        post: post_attributes
      }
    end

    context 'when save is successful' do

      let(:post_attributes) { attributes_for(:post) }
      let(:post_1) { create(:post) }

      it { expect(Post.count).to eq(1) }
      it { expect(subject).to redirect_to(user_post_path(user_1, assigns(:post))) }

    end

    context 'when save is unsuccessful' do

      let(:post_attributes) { attributes_for(:post, title: nil) }

      it { expect(subject).to render_template(:new) }

    end

  end

  describe 'PUT #update' do

    let(:post_1) { create(:post) }

    before do
      put :update, params: {
        user_id: post_1.user,
        id: post_1,
        post: post_attributes
      }
    end

    context 'when update is successful' do

      let(:post_attributes) { attributes_for(:post) }

      it { expect(subject).to redirect_to(user_post_path(post_1.user, assigns(:post))) }

    end

    context 'when update is unsuccessful' do

      let(:post_attributes) { attributes_for(:post, title: nil) }

      it { expect(subject).to render_template(:edit) }

    end

  end

  describe 'delete #destroy' do

    let(:post_1) { create(:post) }

    before do
      delete :destroy, params: {
        user_id: post_1.user,
        id: post_1
      }
    end

    it { expect(assigns(:post)).to be_destroyed }
    it { expect(subject).to redirect_to(user_posts_path) }

  end

end
