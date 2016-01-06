class ApplicationController < ActionController::API

  include Authenticable
  def index
    render text: 'hello'
  end
end

