class AttendanceDecorator < Draper::Decorator
  delegate_all

  def format_excused
    if object.excused == nil
      'pending'
    elsif object.excused
      'accepted'
    else
      'rejected'
    end
  end

  def name_and_date
    object.event.name + " (#{h.format_date(object.event.date)})"
  end
end
