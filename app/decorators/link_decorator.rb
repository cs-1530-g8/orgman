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
    if expiration < Date.today + 18250
      expiration.strftime("%A, %B #{expiration.day.ordinalize} %Y")
    else
      'never'
    end
  end

  def render_remove_link
    if h.current_user.id == user_id || h.current_user.position == Position.first
      h.button_to('remove', h.deactivate_link_path(link),
                  class: 'btn btn-xs btn-danger')
    end
  end
end
