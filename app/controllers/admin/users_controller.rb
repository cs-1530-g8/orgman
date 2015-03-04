class Admin::UsersController < ApplicationController

  before_filter :authenticate_user!
  before_action -> { user_has_position(User::SECRETARY) }

  #### Pending Approvals #######################################################

  def pending_approvals
    @users = User.pending
  end

  def approve_user
    status = params[:status]
    user = User.find(params[:id])
    if user.update(approved: true, status: status)
      ApprovalMailer.accepted(user).deliver
      flash[:notice] = "#{user.name}'s request was accepted. They recieved a" +
        " welcome email."
    else
      flash[:notice] = "There was a problem appriving #{user.name}'s " +
        " request. Try again."
    end
    redirect_to(pending_approvals_path)
  end

  def reject_user
    rejection_message = params[:rejection_message][:message]
    user = User.find(params[:id])
    if user.destroy
      ApprovalMailer.rejected(user, rejection_message).deliver
      flash[:notice] = "#{user.name}'s request was rejected. They recieved an" +
        " email with your rejection message."
    else
      flash[:alert] = "#{user.name}'s request was not rejected. Try again."
    end
    redirect_to(pending_approvals_path)
  end

  #### Update Users ############################################################

  def update_users
    @new_position = Position.new.decorate
    @execs = Position.exec.decorate
    @event_type_admins = Position.event_type_admin.decorate
  end

  def update_status
    status = params[:status]
    user_ids = params[:users_to_update]
    users_to_update = User.where(id: user_ids)
    if users_to_update.update_all(status: status)
      flash[:notice] = "Statuses updated successfully."
    else
      flash[:alert] = "Sorry, there was an issue. Try again"
    end
    redirect_to update_users_path
  end
end
