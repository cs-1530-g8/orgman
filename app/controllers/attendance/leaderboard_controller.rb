class Attendance::LeaderboardController < ApplicationController

  before_action :authenticate_user!

  def index
    sorted_members = User.active.sort_by(&:total_attendance_points)
    sorted_members.reverse!
    @users = UserDecorator.decorate_collection(sorted_members)
  end

end
