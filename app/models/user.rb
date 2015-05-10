class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :city
  has_many :events , through: :attendees


  validates_presence_of :username , :email, :password ,:age , :city , :country, :gender 
  validates_uniqueness_of :email



  validates_presence_of :username , :email, :password ,:age , :city , :country, :gender 
  validates_uniqueness_of :email



attr_accessor :password
  before_save :encrypt_password






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
