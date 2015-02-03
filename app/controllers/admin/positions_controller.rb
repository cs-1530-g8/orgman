class Admin::PositionsController < ApplicationController
  before_action -> { user_has_position(Position.first) }

  def update
    position = Position.find(params[:id])
    if position.update(position_params)
      flash[:notice] = "Event Type Admins updated successfully"
    else
      flash[:alert] = "Event Type Admins updated successfully"
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
  end

  def destroy
    position = Position.find[:id]
    default_positions = Position.where('id < 5')
    if default_positions.include?(position)
      flash[:alert] = "You may not delete the #{position.name} position because
                       it is a default position."
    else
      if position.destroy
        flash[:notice] = "#{position.name} deleted successfully."
      end
    end
  end

  private

  def position_params
    params.require(:position).permit(:user_id)
  end
end
