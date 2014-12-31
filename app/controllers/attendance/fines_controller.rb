class Attendance::FinesController < ApplicationController
  before_action :authenticate_user!, except: [ :update_fines ]

  def index
    @fines = current_user.fines.decorate
  end

  def update
    fine = Fine.find(params[:fine_id])
    paid = params[:paid] == 'true' ? true : false
    fine.update(paid: paid)
  end

  def update_fines
    Event.all.each do |event|
      if event.date < DateTime.now && event.event_type.required?
        event.attendances.each do |attendance|
          if attendance.fine_id.blank? && attendance.excused != true &&
            attendance.present != true && attendance.event.fine > 0
            fine = Fine.new
            fine.user_id = attendance.user_id
            fine.attendance_id = attendance.id
            fine.paid = false
            fine.save
            attendance.update(fine_id: fine.id)
          end
        end
      end
    end
    head :ok
  end

  private

  def fine_params
    params.require(:excuse).permit(:fine_id, :user_id, :paid, :reason)
  end
end
