require 'rails_helper'

RSpec.describe Follow, type: :model do
  it "follower_idとfollowed_idがあれば、モデルが有効になること" do
    expect(FactoryBot.build(:follow)).to be_valid
  end
end
