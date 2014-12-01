module EventsHelper
  # Return the year appended with the current semester.
  # EX: if it is September 2013 return 20132 for 2013 semester 2
  def current_semester(year)
    year *= 10
    if Time.now.month < 7
      year += 1
    else
      year += 2
    end
  end

  def format_semester(year_semester)
    if year_semester % 2 == 0
      "Fall '#{year_semester / 10}"
    else
      "Spring '#{year_semester / 10}"
    end
  end

  def member_can_edit_event(member, event_id)
    event = Event.find(event_id)
    member_can_edit_event_type(member, event.event_type.id)
  end

  def member_can_edit_event_type(member, event_type_id)
    event_type = EventType.find(event_type_id)
    can_edit = false

    if member.position == 'secretary'
      can_edit = true
    elsif member.position == 'risk manager' &&
      event_type.name == 'Ritual Review'
      can_edit = true
    elsif member.position == event_type.name
      can_edit = true
    end

    can_edit
  end
end
