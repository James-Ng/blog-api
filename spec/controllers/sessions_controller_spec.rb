require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
    end
    context "when the user infor is correct" do
      before(:each) do
        @user_info = { email: @user.email, password: @user.password }
        post :create, { session: @user_info }
      end
      it "returns the user record corresponding to the given credentials" do
        @user.reload
        @user_login = json_response
        expect(@user_login[:auth_token]).to eql @user.auth_token
      end
    end
  end
end
