require 'rails_helper'

RSpec.describe FavoriteHabit, type: :model do
  it "habit_idとuser_idがあれば、モデルが有効になること" do
    expect(FactoryBot.build(:favorite_habit)).to be_valid
  end
end
