class Admin::UsersController < ApplicationController

  before_filter :authenticate_user!

  def pending_approvals
    @users = User.where(approved: false)
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
end
