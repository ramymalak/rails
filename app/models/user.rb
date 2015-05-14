class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :city
  has_many :events , through: :attendees


  # validates_presence_of :username , :email, :password , :country, :gender
  # validates_uniqueness_of :email


  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/



  validates_presence_of :username , :email, :password ,:age
  validates_uniqueness_of :email
  validates :password, length: { minimum: 6 }


attr_accessor :password
  before_create :encrypt_password





def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.confirmation(id, password)
    
    @user = User.find(id)
    if @user && @user.password_hash == BCrypt::Engine.hash_secret(password, @user.password_salt)
      @user
    else
      nil
    end
  end




   def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end


 
end
