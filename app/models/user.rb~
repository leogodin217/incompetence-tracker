class User
  include DataMapper::Resource

  property :id,             Serial
  property :username,       String, :required => true, :length => (3..24), :unique => true
  property :email_address,  String, :required => true, :format => :email_address, :unique => true
  property :password_hash,  String, :length => 64, :required => true, :message => "Password must be between 8 and 24 characters long"
  property :password_salt,  String
  
 has n, :contact_records

  def my_contact_records
	ContactRecord.all(:user_id => id)	
  end

  def authenticate(opts)
   
    return false unless self.username == opts[:username]
    Digest::SHA256.hexdigest(opts[:password] + self.password_salt) == self.password_hash
    
  end

  def password=(password)
    if password.present? && password.length >= 8 && password.length <= 24
      salt = rand
      self.password_salt = salt
      self.password_hash = Digest::SHA256.hexdigest(password + salt.to_s)
    end
  end

  def password
    # TODO: Figure out why I need this
  end
end
