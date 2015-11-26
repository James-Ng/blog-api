require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    before(:each) do
      2.times { FactoryGirl.create :user }
      get :index
    end

    it { should respond_with 200 }

    it "returns 2 records" do
      @users = JSON.parse(response.body)
      expect(@users.size).to eql 2
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns the same user' do
      @user_response = JSON.parse(response.body)
      expect(@user_response['email']).to eql @user.email
    end
  end

  describe "POST #create" do
    context 'when created successfully' do
      before(:each) do
        @user = FactoryGirl.attributes_for :user
        post :create, { user: @user }
      end

      it "returns http success" do
        expect(response).to have_http_status(:created)
      end

      it 'returns user just created' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response[:email]).to eql @user[:email]
      end
    end

    context 'when not created' do
      before(:each) do
        @user = { name: FFaker::Name.name }
        post :create, { user: @user }
      end
      it "returns http success" do
        expect(response).to have_http_status(422)
      end
      it 'returns errors' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response).to have_key(:errors)
      end

      it 'returns email errors' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response[:errors][:email]).to include "can't be blank"
      end

    end
  end
end
