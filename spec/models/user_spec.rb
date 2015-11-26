require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }



  describe 'when email is not present' do
    before { @user.email = '' }
    it { should_not be_valid }
  end

  describe 'email should be unique' do
    @older_user = FactoryGirl.create(:user)
    @new_user = FactoryGirl.build(:user)
    @new_user.email = @older_user.email
    it { should_not be_valid }
  end
end


