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

  def render_remove_link
    if user_id == h.current_user.id
      h.link_to(' (remove) ', h.deactivate_quick_link_path(id: link.id))
    end
  end
end
