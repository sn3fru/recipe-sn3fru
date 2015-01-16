class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  has_many :recipes
  has_many :reviews
  has_one  :profile

  #has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :min => "64x64"}, :default_url => "/images/:style/missing.png"
                    #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #validates :username, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false }, format: {with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }
  #validates :avatar, :attachment_presence => true
  #validates_with AttachmentPresenceValidator, :attributes => :avatar
  #validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 3.megabytes
  #validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  # Prepare mailboxer for user
  acts_as_messageable

  after_create :create_profile

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.password = Devise.friendly_token[0,20]
      user.email = auth.info.name
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at
      user.save(validate: false)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def create_profile
    Profile.create(user_id: id, name: name)
  end

  def friends
    self.followees(User)
  end

end