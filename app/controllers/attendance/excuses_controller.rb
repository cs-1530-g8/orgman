class Attendance::ExcusesController < ApplicationController
  before_action :authenticate_user!

  def index
    @excuse = Excuse.new
    @excuses = current_user.excuses.decorate
  end

  def create
    excuse = Excuse.new(excuse_params)
    excuse.user_id = current_user.id
    attendance = Attendance.find_by(event_id: excuse.event_id,
                                    user_id: excuse.user_id)
    if attendance
      excuse.attendance_id = attendance.id
      flash[:notice] = "You have successfully submited an excuse for #{excuse.event.name} on #{format_date(excuse.event.date)}"
    else
      flash[:notice] = 'An error occured. Please contact your administrator to submit your excuse manually'
    end

    excuse.save
    redirect_to excuses_path
  end

  def destroy
  end

  def pending_excuses
  end

  def process_excuse
  end

  private

  def excuse_params
    params.require(:excuse).permit(:event_id, :reason)
  end
end
