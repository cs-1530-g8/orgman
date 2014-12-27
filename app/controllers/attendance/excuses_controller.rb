class Attendance::ExcusesController < ApplicationController
  before_action :authenticate_user!

  def index
    @excuses = current_user.excuses
  end

  def create
  end

  def destroy
  end

  def pending_excuses
  end

  def process_excuse
  end
end
