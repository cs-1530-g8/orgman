class LinkDecorator < Draper::Decorator
  delegate_all

  def format_expiration
    if expiration < Date.today + 18250
      expiration.strftime("%A, %B #{expiration.day.ordinalize} %Y")
    else
      'never'
    end
  end

  def render_remove_link
    if h.current_user.id == user_id ||
       h.current_user.has_position(User::SECRETARY)
      h.link_to('remove', h.deactivate_link_path(link), method: :post,
                class: 'btn btn-xs btn-danger')
    end
  end
end
