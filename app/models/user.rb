class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { is: 4 }
  validates :first_name, :last_name, :email, presence: true
  before_save { self.email.downcase!}

  def self.authenticate_with_password (email, password)
    if email.strip
      email = email.strip 
    end 
      user = User.find_by(email:email.downcase)
      puts user
      if user.authenticate(password)
        return user
      end
      return nil 
  end 
end
