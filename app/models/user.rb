class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :auth_token, uniqueness: true

  before_create :generate_auth_token

  def generate_auth_token
    begin
    	p 'test 1'
    	p 'test 2'
      	p "test pull request" 

      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end
end

