require 'rails_helper'

RSpec.describe Content, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before(:all) do
    @content1 = FactoryBot.create(:content)
    @user1 = @content1.user
  end

  it "is valid with valid attributes" do
    expect(@content1).to be_valid
  end

  it "is not valid without a title" do
    content1 = FactoryBot.build(:content, user: @user1, title: nil)
    expect(content1).to_not be_valid
  end

  it "is not valid without a body" do
    content1 = FactoryBot.build(:content, user: @user1, body: nil)
    expect(content1).to_not be_valid
  end
end
