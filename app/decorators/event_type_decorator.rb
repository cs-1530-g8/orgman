class EventTypeDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def name_field
    if object.name == 'Miscellaneous'
      h.text_field :event_type, :name, {id: "event_type_#{object.id}_name", value: object.name, disabled: true}
    else
      h.text_field :event_type, :name, {id: "event_type_#{object.id}_name", value: object.name}
    end
  end

  def delete_link
    if object.name? && object.name != 'Miscellaneous'
      message = 'Are you sure you want to delete this event type? All events with this type will be moved to the miscallenous type. You will have to manually move each event back to this category if you create it again.'

      h.link_to 'Delete', {controller: :event_types, action: :delete,
                         id: event_type.id }, {confirm: message,
                         class: 'btn btn-danger btn-sm',
                         id: "delete_button_#{event_type.id}"} end
  end
end
