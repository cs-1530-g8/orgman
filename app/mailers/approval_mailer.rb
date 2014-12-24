class ApprovalMailer < ActionMailer::Base
  default from: "admin@orgman.io"

  def accepted(user)
    @user = user
    mail(to: @user.email, subject: 'Start right now with Orgman!')
  end

  def rejected(user, rejection_message)
    @user = user
    @rejection_message = rejection_message
    mail(to: @user.email, subject: 'Rejection notice from Orgman')
  end
end
