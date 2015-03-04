class EventDecorator < Draper::Decorator
  include EventsHelper

  delegate_all

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

  def format_edit_link(member)
    if member.position.present? &&
       (member.position == Position.find_by(name: User::SECRETARY) ||
        member.position.event_type_id == object.event_type.id)
      h.link_to event.name, h.edit_event_path(object)
    else
      h.link_to event.name, h.event_path(object)
    end
  end

  def name_and_date
    object.name + ' (' + h.format_date(object.date) + ')'
  end
end
