require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "titleがあれば有効な状態であること" do
    blog = build(:blog, title: 'dummy')
    expect(blog).to be_valid
  end

  it "titleがなければ無効な状態であること" do
    blog = build(:blog, title: nil)
    expect(blog).to_not be_valid
  end
end
