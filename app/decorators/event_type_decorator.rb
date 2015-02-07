class EventTypeDecorator < Draper::Decorator
  delegate_all

  def name_field
    if object.name == 'Miscellaneous'
      h.text_field :event_type, :name, { value: object.name, disabled: true }
    else
      h.text_field :event_type, :name, { value: object.name }
    end
  end

  def delete_link
    if object.name? && object.name != 'Miscellaneous'
      h.link_to 'Delete', h.event_type_path(self), method: :delete,
        class: 'btn btn-danger btn-sm'
    end
  end
end
