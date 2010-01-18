class User
  include DataMapper::Resource

  property :id,             Serial
  property :username,       String, :required => true
  property :email_address,  String, :required => true
  property :password_hash,  String, :length => 64, :required => true, :message => "Password required"
  property :password_salt,  String

  #validates_with_method :check_password

  def check_password
    if password.present?
      return true
    else
      [false, "You must supply a password"]
    end
  end

  def authenticate(opts)
   
    puts "username sent is #{opts[:username]}, password sent is #{opts[:password]}"
    puts "Self password_salt is #{self.password_salt}"
    return false unless self.username == opts[:username]
    Digest::SHA256.hexdigest(opts[:password] + self.password_salt) == self.password_hash
    
  end

  def password=(password)
    salt = rand
    self.password_salt = salt
    self.password_hash = Digest::SHA256.hexdigest(password + salt.to_s)
  end

  def password
    # TODO: Figure out why I need this
  end
end
