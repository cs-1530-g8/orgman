class UpdateUsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def update_status
    status = params[:status]
    if status != 'alumni' && status != 'active' && status != 'inactive'
      flash[:alert] = 'There was problem updating. Try again.'
      redirect_to update_users_path
    end

    user_ids = params[:users_to_update]
    users_to_update = User.find(user_ids)
    users_to_update.each do |user|
      user.update(status: status)
    end

    flash[:notice] = 'Status updated successfully'
    redirect_to update_users_path
  end
end
