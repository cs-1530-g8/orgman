class PositionDecorator < Draper::Decorator
  delegate_all

  def format_name_field
    if object.event_type.nil?
      if object.is_default_position?
        h.text_field(:position, :name, value: object.name, disabled: true)
      else
        h.text_field(:position, :name, value: object.name)
      end
    else
      h.text_field(:position, :name, { disabled: true,
                                       value: object.event_type.name })
    end
  end

  def render_delete_button
    if event_type_id.nil? && id.present? && id > 5
      h.button_to('remove', h.position_path(self), method: :delete,
                                                   class: 'btn btn-danger')
    end
  end
end
