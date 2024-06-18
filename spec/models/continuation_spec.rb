require 'rails_helper'

RSpec.describe Continuation, type: :model do
  it "nowやuser_id、habit_idがあれば、モデルは有効になること" do
    expect(FactoryBot.build(:continuation)).to be_valid
  end
  it "nowがなければ、モデルは無効になること" do
    expect(FactoryBot.build(:continuation)).to be_invalid
  end
end
