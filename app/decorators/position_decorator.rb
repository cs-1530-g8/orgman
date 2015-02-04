class PositionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def format_name_field
    if object.event_type.nil?
      h.text_field(:position, :name, value: object.name)
    else
      h.text_field(:position, :name, { disabled: true,
                                       value: object.event_type.name })
    end
  end

  def render_delete_button
    if event_type_id.nil? && id.present? && id > 5
      h.button_to('remove', h.position_path(self),
                  { method: :delete, class: 'btn btn-danger' } )
    end
  end
end
