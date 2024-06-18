require 'rails_helper'

RSpec.describe EffectHabit, type: :model do
  it "effect_idとhabit_idがあれば、モデルが有効になること" do
    expect(FactoryBot.build(:effect_habit)).to be_valid
  end
end
