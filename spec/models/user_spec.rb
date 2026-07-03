require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:all) do
    @user1 = FactoryBot.create(:user)
  end
  
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end
  
  it "has a unique email" do
    user1 = FactoryBot.build(:user)
    expect(user1).to_not be_valid
  end

  it "is not valid without a email" do 
    user1 = FactoryBot.build(:user, email: nil)
    expect(user1).to_not be_valid
  end

  it "is not valid without a first_name" do 
    user1 = FactoryBot.build(:user, email: "johnvoy1@gmail.com", first_name: nil)
    expect(user1).to_not be_valid
  end

  it "is not valid without a last_name" do 
    user1 = FactoryBot.build(:user, email: "johnvoy1@gmail.com", last_name: nil)
    expect(user1).to_not be_valid
  end

  it "is not valid without a password" do 
    user1 = FactoryBot.build(:user, email: "johnvoy1@gmail.com", password: nil)
    expect(user1).to_not be_valid
  end
end
