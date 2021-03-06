class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :peoplesoft_number,
                                 :two_p_number, :address, :phone_number, :about,
                                 :avatar)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :peoplesoft_number,
                                 :two_p_number, :address, :phone_number, :about,
                                 :avatar, :current_password)
  end
end
