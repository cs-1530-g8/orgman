class EventsController < ApplicationController

  include EventsHelper
  include ApplicationHelper

  before_action :signed_in_member
  before_action -> { member_can_edit_event(@current_member, params[:id])},
                only: [:edit]
  before_action -> { unless member_can_edit_event_type(@current_member, params[:event][:event_type_id])
                        flash[:attention] = "Sorry you are not authorized to edit this event!"
                        redirect_to event_path(event_id)
                     end}, only: [:create, :update]

  def index
    #todo only events from current semester
    @events = Event.all.decorate
  end

  def show
    @event = Event.find(params[:id]).decorate
  end

  def new
    if @current_member.position == nil || @current_member.position == ''
      flash[:attention] = 'You must be a chairman or the secretary to add an event'
      redirect_to signin_path
    end
    @event = Event.new.decorate
  end

  def create
    @event = Event.new(event_params)
    @event.semester = current_semester(Time.now.year)

    if @event.save
      member_ids = params[:event][:attendances][:member_ids].reject{|s| s.blank?}
      absent = Member.active - Member.find(member_ids)

      member_ids.each do |member_id|
        Attendance.create(member_id: member_id, event_id: @event.id, present: true)
      end

      absent.each do |member|
        Attendance.create(member: member, event_id: @event.id, present: false)
      end

      flash[:attention] = "#{@event.name} on #{format_date @event.date} created
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

      member_ids = params[:event][:attendances][:member_ids].reject{|s| s.blank?}
      old_present = Attendance.where(event_id: @event.id, present: true)
        .map{|a| a.member_id.to_s}
      new_present = member_ids - old_present
      new_absent = old_present - member_ids

      new_present.each do |m|
        a = Attendance.where(event_id: @event.id, member_id: m).first
        a.update_attribute(:present, true)
      end

      new_absent.each do |m|
        a = Attendance.where(event_id: @event.id, member_id: m).first
        a.update_attribute(:present, false)
      end

      flash[:attention] = "#{@event.name} on #{format_date @event.date} updated
                          successfully."
      redirect_to(@event)
    else
      render 'edit'
    end
  end

  #todo Do we want to implement a destroy for events?
  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :fine, :self_submit_attendance,
                                  :self_submit_excuse, :attendances,
                                  :event_type_id)
  end
end # end Events controller
