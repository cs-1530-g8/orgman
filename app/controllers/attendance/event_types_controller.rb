class Attendance::EventTypesController < ApplicationController
  before_action :authenticate_user!
  before_filter -> { user_has_position("Secretary") }

  def index
    @event_types = EventType.all.decorate
    @new_event_type = EventType.new.decorate
  end

  def create
    @event_type = EventType.new(event_type_params)

    if @event_type.save
      position = Position.new(event_type: @event_type)
      if position.save
        flash[:notice] = "#{@event_type.name} created successfully."
      end
    else
      flash[:alert] = "\"#{@event_type.name}\" was not created"
    end
    @event_type = @event_type.decorate
    redirect_to(event_types_path)
  end

  def update
    @event_type = EventType.find(params[:id])
    if @event_type.update(event_type_params)
      @event_type.reload
      flash[:notice] = "#{@event_type.name} updated successfully."
      redirect_to(event_types_path)
    else
      flash[:alert] = "Updating #{@event_type.name} failed."
      redirect_to(event_types_path)
    end
  end

  def destroy
    @event_type = EventType.find(params[:id])
    @events = @event_type.events
    @events.update_all(event_type_id: 1)

    if @event_type.position.destroy!
      if @event_type.destroy!
        flash[:notice] = "\"#{@event_type.name}\" was deleted."
      else
        flash[:alert] = "Deleting \"#{@event_type.name}\" failed."
      end
    else
      flash[:alert] = "Deleting \"#{@event_type.name}\" failed."
    end

    redirect_to(event_types_path)
  end

  private

  def event_type_params
    params.require(:event_type).
      permit(:name, :points_required, :percentage_attendance_required)
  end
end
