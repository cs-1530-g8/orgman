class DashboardController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def dashboard
  end
end
