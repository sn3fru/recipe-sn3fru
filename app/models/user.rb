class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  has_many :recipes
  has_many :reviews
  has_one  :profile

  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :min => "64x64"}, :default_url => "/images/:style/missing.png"
                    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false }, format: {with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }
  validates :avatar, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :avatar
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 3.megabytes
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  # Prepare mailboxer for user
  acts_as_messageable


  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  #Mailer Methods
  def name
    email
  end

  def mailboxer_email(object)
    email
  end

  #Methods for Socialization User attributes
  acts_as_follower
  acts_as_followable
  has_many :posts
  has_many :comments
  acts_as_liker
  acts_as_likeable
  acts_as_mentionable


  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

end