require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'validations' do
    
    it 'is valid to save' do
    @user = User.new(
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
      expect(@user).to be_valid
    end
  
    it 'is invalid due to the mismatch of password and password confirmation' do
      @user = User.new(
        first_name: 'Jeongmin',
        last_name: 'Choi',
        email: 'jeongmin@test.com',
        password: 'password',
        password_confirmation: 'password1'
      )
      expect(@user).not_to be_valid
    end
    
    it 'has first name required' do
      @user = User.new(     
      first_name: nil,
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: 'password'
      )
      expect(@user).not_to be_valid
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'has last name required' do
      @user = User.new(     
      first_name: 'Jeongmin',
      last_name: nil,
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: 'password'
      )
      expect(@user).not_to be_valid
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it 'has email required' do
      @user = User.new(     
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: nil,
      password: 'password',
      password_confirmation: 'password'
      )
      expect(@user).not_to be_valid
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'has password required' do
      @user = User.new(     
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: nil,
      password_confirmation: 'password'
      )
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'has password confirmation required' do
      @user = User.new(     
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: nil
      )
      expect(@user).not_to be_valid
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'emails must be unique' do
      @user = User.new(
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: 'password'
      )
      @user.save

      user2 = User.new(
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password',
      password_confirmation: 'password'
      )
      user2.save
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'requires less than 7 letters for password' do
    @user = User.new(
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'pass',
      password_confirmation: 'pass'
      )
      @user.save

    user2 = User.new(
      first_name: 'Jeongmin',
      last_name: 'Choi',
      email: 'jeongmin@test.com',
      password: 'password12',
      password_confirmation: 'password12'
      )
      user2.save
    expect(user2).to be_valid
    expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'allows to log in when password and email are vaild' do
      @user = User.new(first_name: 'Jeongmin', last_name: 'Choi', email: 'jeongmin@test.com', password: 'password', password_confirmation: 'password')
      @user.save

    also_valid = User.authenticate_with_credentials('jeongmin@test.com', 'password')

    expect(also_valid).to eq(@user)
    end
  
    it 'allows when email is Uppercase' do
      @user = User.new(first_name: 'Jeongmin', last_name: 'Choi', email: 'jeongmin@test.com', password: 'password', password_confirmation: 'password')
      @user.save

      also_valid = User.authenticate_with_credentials('JEONGMIN@test.com', 'password')
      expect(also_valid).to eq(@user)
    end

    it 'allows when email has spaces' do
      @user = User.new(first_name: 'Jeongmin', last_name: 'Choi', email: 'jeongmin@test.com', password: 'password', password_confirmation: 'password')
      @user.save

      also_valid = User.authenticate_with_credentials(' JEONGMIN@test.com ', 'password')
      expect(also_valid).to eq(@user)
    end
  end
end
