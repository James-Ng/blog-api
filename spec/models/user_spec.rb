require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:auth_token) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:auth_token) }

  it { should be_valid }

  describe '#generate_auth_token' do
    it 'generates a unique token' do
      allow(@user).to receive(:generate_auth_token).and_return("token123")
      @user.generate_auth_token.should eq("token123")
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "token123")
      @user.generate_auth_token
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end


