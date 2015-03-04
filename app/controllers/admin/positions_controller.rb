class Admin::PositionsController < ApplicationController
  before_action -> { user_has_position(User::SECRETARY)}

  def update
    position = Position.find(params[:id])
    if position.update(position_params)
      flash[:notice] = "Positions updated successfully"
    else
      flash[:alert] = "Positions updated successfully"
    end
    redirect_to update_users_path
  end

  def create
    position = Position.new(position_params)
    if position.save
      flash[:notice] = "\"#{position.name}\" created successfully"
    else
      flash[:alert] = "\"#{position.name}\" was not created successfully"
    end
    redirect_to update_users_path
  end

  def destroy
    position = Position.find(params[:id])
    if position.default_position?
      flash[:alert] = "You may not delete the #{position.name} position because
                       it is a default position."
    else
      if position.destroy
        flash[:notice] = "#{position.name} deleted successfully."
      end
    end
    redirect_to update_users_path
  end

  private

  def position_params
    params.require(:position).permit(:name, :user_id)
  end
end
