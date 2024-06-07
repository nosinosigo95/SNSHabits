require 'rails_helper'

RSpec.describe GoodHabit, type: :model do
  it "習慣名と効果、作成したユーザIDを入力すれば、モデルが有効になること" do
  end

  it "習慣名とユーザーIDの組が重複していると、モデルが無効になること" do
  end

  it "習慣名がなければ、モデルが無効になること" do
  end
  it "習慣名がスペースだけならば、モデルが無効になること" do
  end

  it "効果がなければ、モデルが無効になること" do
  end
  it "効果がスペースだけならば、モデルが無効になること" do
  end
  it "効果の文字数が400文字を超えると、モデルが無効になること" do
  end

  it "作成したユーザーIDがなければ、モデルが無効になること" do
  end
  it "作成したユーザーIDがスペースだけならば、モデルが無効になること" do
  end

  it "効果の文字数が400文字を超えると、モデルが無効になること" do
  end
end
