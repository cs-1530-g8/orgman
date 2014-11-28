class LeaderboardController < ApplicationController

  before_action :signed_in_member

  def index
    sorted_members = Member.active.sort_by(&:total_attendance_points)
    sorted_members.reverse!
    @members = MemberDecorator.decorate_collection(sorted_members)
  end

end
