require 'rails_helper'

class Authentication
  include Authenticable
end

describe Authenticable, type: :controller  do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      allow(authentication).to receive(:request_author_token).and_return(@user.auth_token)
    end
    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      allow(authentication).to receive(:current_user).and_return(nil)
      authentication.authenticate_with_token!
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it {  should respond_with 401 }
  end
end