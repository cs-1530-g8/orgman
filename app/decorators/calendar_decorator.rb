class CalendarDecorator < Draper::Decorator
  delegate_all

  def render_destroy_link
    if h.current_user.position.present? &&
      (h.current_user.position == Position.find_by(name: User::SECRETARY))
      h.link_to "remove", h.calendar_path(object),
        { method: :delete, class: 'btn btn-danger btn-xs' }
    end
  end

  def render_new_calendar
    if h.current_user.position.present? &&
      (h.current_user.position == Position.find_by(name: User::SECRETARY))
      h.render partial: "new_calendar"
    end
  end
end
