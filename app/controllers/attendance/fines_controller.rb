class Attendance::FinesController < ApplicationController
  before_action :authenticate_user!, except: [:update_fines]
  before_action -> { user_has_position(Position.first) },
                only: [:outstanding_fines]

  def index
    @fines = current_user.fines.decorate
  end

  def outstanding_fines
    @fines = Fine.where(paid: false).decorate
  end

  def update
    fine = Fine.find(params[:id])
    paid = params[:paid] == 'true' ? true : false
    fine.update(paid: paid)
    redirect_to outstanding_fines_path
  end

  def update_fines
    Event.all.each do |event|
      if event.date < DateTime.now && event.fine.present?
        event.attendances.each do |attendance|
          if attendance.fine.nil? && attendance.excused != true &&
            attendance.present != true
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
