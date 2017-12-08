require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "titleがあれば有効な状態であること" do
    blog = Blog.new(title: 'dummy')
    expect(blog).to be_valid
  end

  it "titleがなければ無効な状態であること" do
    blog = Blog.new(title: nil)
    expect(blog).to_not be_valid
  end
end
