class EventDecorator < Draper::Decorator
  include EventsHelper

  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def format_self_submit_attendance(user)
    if object.self_submit_attendance
      attendance = Attendance.where(user_id: user.id, event_id: object.id)
      if attendance.count > 0
        if attendance.first.present == true
          'You attended this event'
        else
          h.render partial: 'attendance/attendances/self_report',
                   locals: { attendance: attendance.first }
        end
      end
    else
      'You may not submit your own attendance for this event.'
    end
  end

  def valid_event_types(member)
    if member.position == 'secretary'
      EventType.all
    else
      editable_event_types = EventType.where(name: member.position)
      if member.position == 'Risk Manager'
        editable_event_types += EventType.where(name: 'Ritual Review')
      end
      editable_event_types
    end
  end

  def format_edit_link(member)
    if member_can_edit_event_type(member, object.event_type_id)
      h.link_to event.name, h.edit_event_path(object)
    else
      h.link_to event.name, h.event_path(object)
    end
  end
end
