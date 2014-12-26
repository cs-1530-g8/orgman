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
    update_position_for_user_id(params[:president], User.president)
    update_position_for_user_id(params[:vice_president], User.vice_president)
    update_position_for_user_id(params[:secretary], User.secretary)
    update_position_for_user_id(params[:treasurer], User.treasurer)
    update_position_for_user_id(params[:alumni_relations], User.alumni_relations)
    update_position_for_user_id(params[:risk_manager], User.risk_manager)
    update_position_for_user_id(params[:recruitment], User.recruitment)
    update_position_for_user_id(params[:social], User.social)
    update_position_for_user_id(params[:amc], User.amc)
    update_position_for_user_id(params[:jamc], User.jamc)
    update_position_for_user_id(params[:house_manager], User.house_manager)

    flash[:notice] = 'Positions updated successfully'
    redirect_to update_users_path
  end

  private

  def update_position_for_user_id(user_id, position)
    # Clear the old position holder
    old_user_with_position = User.find_by(position: position)
    if old_user_with_position
      old_user_with_position.update(position: nil)
    end

    # Set the new position holder
    if !user_id.blank?
      user = User.find(user_id)
      user.update(position: position)
    end
  end
end
