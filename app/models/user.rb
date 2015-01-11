class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :reviews
  has_one  :profile

  acts_as_follower
  acts_as_followable

  acts_as_liker
  acts_as_mentionable

  acts_as_messageable

end
