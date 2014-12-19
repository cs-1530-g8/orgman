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

  def update_positions
    unless params[:president].blank?
      user = User.find(params[:president])
      user.update(position: User.president)
    end

    unless params[:vice_president].blank?
      user = User.find(params[:vice_president])
      user.update(position: User.vice_president)
    end

    unless params[:secretary].blank?
      user = User.find(params[:secretary])
      user.update(position: User.secretary)
    end

    unless params[:treasurer].blank?
      user = User.find(params[:treasurer])
      user.update(position: User.treasurer)
    end

    unless params[:alumni_relations].blank?
      user = User.find(params[:alumni_relations])
      user.update(position: User.alumni_relations)
    end

    unless params[:risk_manager].blank?
      user = User.find(params[:risk_manager])
      user.update(position: User.risk_manager)
    end

    unless params[:recruitment].blank?
      user = User.find(params[:recruitment])
      user.update(position: User.recruitment)
    end

    unless params[:social].blank?
      user = User.find(params[:social])
      user.update(position: User.social)
    end

    unless params[:amc].blank?
      user = User.find(params[:amc])
      user.update(position: User.amc)
    end

    unless params[:jamc].blank?
      user = User.find(params[:jamc])
      user.update(position: User.jamc)
    end

    unless params[:house_manager].blank?
      user = User.find(params[:house_manager])
      user.update(position: User.house_manager)
    end

    flash[:notice] = 'Positions updated successfully'
    redirect_to update_users_path
  end
end
