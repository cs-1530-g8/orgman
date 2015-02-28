class Attendance::EventsController < ApplicationController
  include EventsHelper

  before_action :authenticate_user!
  before_action -> { can_create_events }, only: [:new]
  before_action -> { can_edit_event(params[:id]) }, only: [:edit, :update]
  before_action -> { can_edit_event_type(params[:event][:event_type_id]) },
                only: [:create]

  # todo only events from current semester
  def index
    @events = Event.all.decorate
  end

  def show
    @event = Event.find(params[:id]).decorate
    @attended = @event.attended_users
    @absent = @event.absent_users
    @unexcused_and_absent = @event.absent_users
  end

  def new
    @event = Event.new.decorate
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      user_ids = params[:event][:attendances][:user_ids].reject { |s| s.blank? }
      absent = User.active - User.find(user_ids)

      user_ids.each do |user_id|
        Attendance.create(user_id: user_id, event: @event, present: true)
      end

      absent.each do |user|
        Attendance.create(user: user, event: @event)
      end

      flash[:notice] = "#{@event.name} on #{format_date(@event.date)} created
                           successfully."
    end

    redirect_to(@event)
  end

  def edit
    @event = Event.find(params[:id])
    @event = @event.decorate
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      @event.reload

      user_ids = params[:event][:attendances][:user_ids].reject{|s| s.blank?}
      old_present = Attendance.where(event_id: @event.id, present: true).
        map { |a| a.user_id.to_s }
      new_present = user_ids - old_present
      new_absent = old_present - user_ids

      new_present.each do |m|
        a = Attendance.where(event_id: @event.id, user_id: m).first
        a.update_attribute(:present, true)
      end

      new_absent.each do |m|
        a = Attendance.where(event_id: @event.id, user_id: m).first
        a.update_attribute(:present, false)
      end

      flash[:notice] = "#{@event.name} on #{format_date @event.date} updated
                          successfully."
      redirect_to(@event)
    else
      flash[:alert] = "There was problem updating the event. Try again"
      redirect_to(edit_event_path(@event))
    end
  end

  # todo Do we want to implement a destroy for events?
  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :fine, :self_submit_attendance,
                                  :self_submit_excuse, :attendances,
                                  :event_type_id)
  end
end # end Events controller
