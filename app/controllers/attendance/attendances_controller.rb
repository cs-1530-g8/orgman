class Attendance::AttendancesController < ApplicationController
  before_action :authenticate_user!

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update(attendance_params)
      flash[:notice] = 'You have successfully self reported your attendance'
    else
      flash[:alert] = 'Sorry but there was an error while self-reporting.'
    end
    redirect_to(event_path(@attendance.event_id))
  end

  private

  def attendance_params
    params.require(:attendance).permit(:present)
  end

end
