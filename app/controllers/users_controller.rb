class UsersController < ApplicationController
  before_action :authenticate_user!

  def info
    render :info
  end
end
