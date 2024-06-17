require 'rails_helper'

RSpec.describe Diary, type: :model do
  it "記述と作業時間、プライベートを入力すれば、モデルは有効になること"

  it "記述がなければ、モデルは無効になること"
  it "記述が空白ならば、モデルは無効になること"
  it "記述が600文字を超えるならば、モデルは無効になること"

  it "作業時間がなければ、モデルは無効になること"
  it "作業時間が空白ならば、モデルは無効になること"

  it "プライベートがなければ、モデルは無効になること"
  it "プライベートが空白ならば、モデルは無効になること"
end
