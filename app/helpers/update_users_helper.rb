module UpdateUsersHelper
  def user_id_for_position(position)
    user = User.find_by(position: position)
    user_id = user == nil ? 0 : user.id
  end
end
