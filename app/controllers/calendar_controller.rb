class CalendarController < ApplicationController
  before_filter :authenticate_user!
  before_filter -> { user_has_position(User::SECRETARY) }, only: [:create,
                                                                  :destroy]
  def index
    @display_calendar = Calendar.primary_calendar.decorate
    @non_displayed_calendars = Calendar.non_primary_calendars.decorate
    @new_calendar = Calendar.new.decorate
  end

  def show
    @display_calendar = Calendar.find(params[:id]).decorate
    @non_displayed_calendars = Calendar.exclude(params[:id]).decorate
    @new_calendar = Calendar.new.decorate
    render "index"
  end

  def create
    calendar = Calendar.new(calendar_params)
    if calendar.save
      flash[:notice] = "#{calendar.name} saved."
    else
      flash[:alert] = "Adding #{calendar.name} failed, try again."
    end
    redirect_to calendars_path
  end

  def destroy
    calendar = Calendar.find(params[:id])
    if calendar.primary && Calendar.count > 1
      new_primary_calendar = Calendar.exclude(calendar.id).first
      new_primary_calendar.update(primary: true)
    end
    if calendar.destroy
      flash[:notice] = "#{calendar.name} was deleted."
    else
      flash[:alert] = "Deleting #{calendar.name} failed =("
    end
    redirect_to calendars_path
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name, :url, :primary)
  end
end
