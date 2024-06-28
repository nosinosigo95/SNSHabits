require 'rails_helper'

RSpec.describe Effect, type: :model do
  it "効果が存在するとき、モデルは有効であること" do
    expect(FactoryBot.build(:effect)).to be_valid
  end
  it "効果が空白であるとき、モデルは無効であること" do
    expect(FactoryBot.build(:effect, effect_item: " ")).to be_invalid
  end
  it "効果が存在しないとき、モデルは無効であること" do
    expect(FactoryBot.build(:effect, effect_item: nil)).to be_invalid
  end
  it "効果名が重複していたならば、モデルは無効であること" do
    FactoryBot.create(:effect, effect_item: "効果効果")
    effect = FactoryBot.build(:effect, effect_item: "効果効果")
    effect.valid?
    expect(effect.errors[:effect_item]).to include("はすでに存在します")
  end
end
