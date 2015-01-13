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
      "Fall #{year_semester / 10}"
    else
      "Spring #{year_semester / 10}"
    end
  end

  def excusable_events
    required_events = []
    EventType.required.each do |et|
      et.events.each do |e|
        if e.date > DateTime.now && e.self_submit_excuse
          required_events.push(e)
        end
      end
    end
    required_events
  end
end
