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
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
