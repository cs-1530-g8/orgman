class Attendance::ExcusesController < ApplicationController
  before_action :authenticate_user!
  before_action -> { user_has_position(User::SECRETARY) },
                only: [:destroy, :process_excuse, :pending_excuses]

  def index
    @excuses = Attendance.find_existing_excuses(current_user).decorate
    @possible_excuses = Attendance.find_possible_excuses(current_user).decorate
  end

  def submit_excuse
    attendance = Attendance.find(params[:attendance][:id])
    if attendance.update(excuse_params)
      flash[:notice] = "You have successfully submited an excuse for
                      #{attendance.event.name} on
                      #{format_date(attendance.event.date)}"
    else
      flash[:notice] = 'An error occured. Please ask your administrator to
                        submit your excuse manually'
    end

    redirect_to excuses_path
  end

  def pending_excuses
    @excuses = Attendance.pending_excuses
  end

  def process_excuse
    accepted = params[:accepted] == 'true' ? true : false
    attendance = Attendance.find(params[:id])

    if attendance.update(excused: accepted)
      name = attendance.user.name
      event = attendance.event.name
      date = format_date(attendance.event.date)
      result = accepted ? 'accepted' : 'rejected'
      flash[:notice] = "#{name}'s excuse for #{event} on #{date} was #{result}"
    else
      flash[:alert] = "There was a problem! Please manually add an excuse for
                       the user."
    end

    redirect_to pending_excuses_path
  end

  private

  def excuse_params
    params.require(:attendance).permit(:id, :excuse_reason)
  end
end
