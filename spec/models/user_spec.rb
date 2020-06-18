require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    user_attributes = {
      first_name: "baba",
      last_name: 'Le roux',
      status: 0,
      email: "test@gmail.com",
      password: "secret",
      phone_number: "06 06 06 06 06"
    }
  }

  it 'should be valid with valid attribute' do
    user = User.new(subject)
    expect(user).to be_valid
  end

  it 'should be not valid without first_name attribute' do
    user = User.new(subject)
    user.first_name = nil
    expect(user).to_not be_valid
  end

  it 'should be only an integer' do
    user = User.new(subject)
    expect(user).to be_valid

    user.mp_user_id = 'test'
    expect(user).to_not be_valid

    user.mp_user_id = 4
    expect(user).to be_valid
  end

  it 'should be not valid without last_name attribute' do
    user = User.new(subject)
    user.last_name = nil
    expect(user).to_not be_valid
  end

  it 'should be not valid without password attribute' do
    user = User.new(subject)
    user.password = nil
    expect(user).to_not be_valid
  end

  describe 'email attribute' do
    it 'should be not valid without email attribute' do
      user = User.new(subject)
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'should be not valid with wrong email' do
      user = User.new(subject)
      user.email = "/@gmail.com"
      expect(user).to_not be_valid
      user.email = "bernard@.com"
      expect(user).to_not be_valid
      user.email = "bernard.gmail.com"
      expect(user).to_not be_valid
    end 
  end

  describe 'status attribute' do
    it 'should be not valid without status attribute' do
      user = User.new(subject)
      user.status = nil
      expect(user).to_not be_valid
    end 
    it 'should be equal to 0 or 1' do
      user = User.new(subject)
      user.status = 5
      expect(user).to_not be_valid
    end
  end

  describe 'phone_number attribute' do
    it 'should be not valid without phone_number attribute' do
      user = User.new(subject)
      user.phone_number = nil
      expect(user).to_not be_valid
    end

    it 'phone_number should have a good format "06 06 06 06 06"' do
      user = User.new(subject)
      user.phone_number = "06 06"
      expect(user).to_not be_valid

      user.phone_number = "0606"
      expect(user).to_not be_valid

      user.phone_number = "06-06-06-06-06"
      expect(user).to_not be_valid

      user.phone_number = "+33 6 06 06 06 06"
      expect(user).to_not be_valid

      user.phone_number = "06 06 06 06 06 06"
      expect(user).to_not be_valid
    end
  end 
end 