class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def attendance_count_for_event_type(type)
    attendances_for_event_type = object.attendances.select do |attendance|
      attendance.present &&
        Event.find(attendance.event_id).event_type_id == type.id
    end
    attendances_for_event_type.count
  end

  def attendance_count_for_not_required
    event_ids = EventType.not_required.map(&:id)
    not_required_attendance_ids_for_member = object.attendances.
      where(present: true).select do |attendance|
        event_ids.include?(attendance.event.event_type.id)
    end
    not_required_attendance_ids_for_member.count
  end

  def parent_name
    object.parent_id.present? ? User.find(parent_id).name : '[unknown]'
  end
end
