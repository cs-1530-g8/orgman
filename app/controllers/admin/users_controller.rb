class Admin::UsersController < ApplicationController

  before_filter :authenticate_user!

  def pending_approvals
    @users = User.where(approved: false)
  end

  def approve_user
    id = params[:id]
    status = params[:status]
    user = User.find(id)
    if params[:approve] == 'true'
      user.update(approved: true, status: status)
    end
    redirect_to(pending_approvals_path)
  end
end
