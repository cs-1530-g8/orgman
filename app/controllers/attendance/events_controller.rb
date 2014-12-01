class Attendance::EventsController < ApplicationController
  include EventsHelper
  include ApplicationHelper

  before_action :authenticate_user!
  before_action -> { member_can_edit_event(current_user, params[:id]) },
                   only: [:edit]
  before_action -> {
    unless member_can_edit_event_type(current_user,
                                      params[:event][:event_type_id])
      flash[:alert] = "Sorry you are not authorized to edit this event!"
      redirect_to event_path(event_id)
    end
  }, only: [:create, :update]

  # todo only events from current semester
  def index
    @events = Event.all.decorate
  end

  def show
    @event = Event.find(params[:id]).decorate
    @attended_users = @event.attended_users.sort_by {
      |u| [u.last_name, u.first_name]
    }
    @absent_users = @event.absent_users.sort_by {
      |u| [u.last_name, u.first_name]
    }
  end

  def new
    if current_user.position.blank?
      flash[:alert] = 'You must be a chairman or the secretary to add an event'
      redirect_to events_path
    end
    @event = Event.new.decorate
  end

  def create
    @event = Event.new(event_params)
    @event.semester = current_semester(Time.now.year)

    if @event.save
      user_ids = params[:event][:attendances][:user_ids].reject { |s| s.blank? }
      absent = User.active - User.find(user_ids)

      user_ids.each do |user_id|
        Attendance.create(user_id: user_id, event_id: @event.id, present: true)
      end

      absent.each do |user|
        Attendance.create(user: user, event_id: @event.id, present: false)
      end

      flash[:notice] = "#{@event.name} on #{format_date @event.date} created
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
