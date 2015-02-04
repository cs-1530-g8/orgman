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
end
