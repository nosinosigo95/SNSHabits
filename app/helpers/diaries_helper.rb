module DiariesHelper
  def get_favorite_habit
    favorite_habit = {}
    current_user.favorites.each do |habit|
      favorite_habit[habit.name] = habit.id
    end
    favorite_habit
  end
end
