class Admin::UsersController < ApplicationController
  def approve_users
    if params[:approved] == "false"
      @users = User.where(approved: false)
    else
      @users = User.all
    end
  end
end
