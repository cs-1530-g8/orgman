class ExternalController < ApplicationController
  def index
    if current_user
      redirect_to dashboard_path
    end
  end

  def site_map
  end

  def members
    @users = UserDecorator.decorate_collection(User.active)
  end
end
