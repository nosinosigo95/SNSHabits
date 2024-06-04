module UserHelper
  def get_user_icon(user)
    if user.icon.attached?
      user.icon
    else
      'person-circle.svg'
    end
  end
end
