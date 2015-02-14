class Attendance::FinesController < ApplicationController
  before_action :authenticate_user!, except: [:update_fines]
  before_action -> { user_has_position("Secretary") },
                only: [:outstanding_fines, :update]

  def index
    @fines = current_user.fines.decorate
  end

  def outstanding_fines
    @fines = Fine.unpaid.decorate
  end

  def update
    fine = Fine.find(params[:id])
    paid = params[:paid] == 'true' ? true : false
    fine.update(paid: paid)
    redirect_to outstanding_fines_path
  end

  def update_fines
    unfined = Attendance.find_unfined
    unfined.each { |a| Fine.create(attendance: a) }
    head :ok
  end

  private

  def fine_params
    params.require(:excuse).permit(:fine_id, :user_id, :paid, :reason)
  end
end
