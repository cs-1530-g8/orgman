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
      excuse.save
      attendance.update(excuse_id: excuse.id)

      flash[:notice] = "You have successfully submited an excuse for
                      #{excuse.event.name} on #{format_date(excuse.event.date)}"
    else
      flash[:notice] = 'An error occured. Please ask your administrator to
                        submit your excuse manually'
    end

    redirect_to excuses_path
  end

  def destroy
  end

  def pending_excuses
    @excuses = Excuse.pending
  end

  def process_excuse
    accepted = params[:accepted] == 'true' ? true : false
    excuse = Excuse.find(params[:excuse_id])
    attendance = excuse.attendance

    if attendance && excuse
      name = excuse.user.name
      event = excuse.event
      date = format_date(excuse.event.date)
      result = accepted ? 'accepted' : 'rejected'

      attendance.update(excused: true)
      excuse.update(accepted: accepted)
      flash[:notice] = "#{name}'s excuse for #{event} on #{date} was #{result}"
    else
      flash[:alert] = "There was a problem! Please manually add an excuse for the user."
    end

    redirect_to pending_excuses_path
  end

  private

  def excuse_params
    params.require(:excuse).permit(:event_id, :reason)
  end
end
