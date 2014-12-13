class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 attr_accessor :email, :first_name, :last_name, :profile_name, :password, :password_confirmation, :remember_me         


  has_many :user


end
