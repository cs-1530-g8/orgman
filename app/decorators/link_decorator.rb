class LinkDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def format_expiration
    if expiration
      expiration.strftime("%A, %B #{expiration.day.ordinalize} %Y")
    else
      'never'
    end
  end

  def edit_button
    if user_id == h.current_user.id
      h.current_user.name + " (edit)"
    end
  end

end
