require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
  it "User is invalid if missing password and password_confirmation" do
    user = User.new(first_name:"aa",email:"aa@gmail.com")
    puts user.valid?
    expect(user.valid?).to be_falsey
  end

  it "User is invalid if email is missing" do
    user = User.new(first_name:"aa",last_name:"aa",password:"abcd",password_confirmation:"abcd")
    puts user.valid?
    expect(user.valid?).to be_falsey
  end

  it "User is invalid if first name is missing" do
    user = User.new(last_name:"aa",password:"abcd",password_confirmation:"abcd")
    puts user.valid?
    expect(user.valid?).to be_falsey
  end

  it "User is invalid if last name is missing" do
    user = User.new(first_name:"aa",password:"abcd",password_confirmation:"abcd")
    puts user.valid?
    expect(user.valid?).to be_falsey
  end

  it "User is valid if password  match" do
    user = User.new(first_name:"aa",last_name:"aa",email:"aa@gmail.com",password:"abcd",password_confirmation:"abcd")
    puts user.valid?
    expect(user.valid?).to be_truthy
  end

  it "User is invalid if password do not match" do
    user = User.new(first_name:"aa",last_name:"aa",email:"aa@gmail.com",password:"a",password_confirmation:"aa")
    puts user.valid?
    expect(user.valid?).to be_falsey
  end

 it "User is invalid if email match" do
  user = User.new(first_name:"aa",last_name:"aa",email:"aa@gmail.com",password:"abcd",password_confirmation:"abcd")
  expect(user.save).to be_truthy
  user1 = User.new(first_name:"aa",last_name:"aa",email:"Aa@gmail.com",password:"abcd",password_confirmation:"abcd")
  expect(user1.save).to be_falsey
 end

 it "User invalid when password length is less than 4" do
  user = User.new(first_name:"aa",last_name:"aa",email:"aa@gmail.com",password:"aa",password_confirmation:"aa")
  
  expect(user.valid?).to be_falsey
end



end


describe '.authenticate_with_credentials' do
  it "valid with existing email and password" do
  user = User.new(first_name:"aa",last_name:"aa",email:"aab@gmail.com",password:"abcd",password_confirmation:"abcd")
  expect(user.save)
  expect(User.authenticate_with_password("aab@gmail.com","abcd")).to be_truthy
  end

  it "invalid with non existing email or password" do
    user = User.new(first_name:"aa",last_name:"aa",email:"aab@gmail.com",password:"abcd",password_confirmation:"abcd")
    expect(user.save)
    expect(User.authenticate_with_password("aab@gmail.com","abcd1")).to be_falsey
    end

  it "valid with email having trailing and leading spaces" do
      user = User.new(first_name:"aa",last_name:"aa",email:"aab@gmail.com",password:"abcd",password_confirmation:"abcd")
      user.save
      expect(User.authenticate_with_password(" aab@gmail.com ","abcd")).to be_truthy
  end

  it "valid with email with different case" do
    user = User.new(first_name:"aa",last_name:"aa",email:"aab@gmail.com",password:"abcd",password_confirmation:"abcd")
    user.save
    expect(User.authenticate_with_password("Aab@gmail.com","abcd")).to be_truthy
end
end

end
