class AttendancesController < ApplicationController

  before_action :signed_in_member

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update_attributes(attendance_params)
      flash[:success] = 'You have successfully self reported your attendance'
    else
      flash[:error] = 'Sorry but there was an error while self-reporting'
    end
    redirect_to(event_path(@attendance.event_id))
  end

  private
    def attendance_params
      params.require(:attendance).permit(:member_id, :event_id, :present)
    end

end
