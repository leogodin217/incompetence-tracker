class User
  include DataMapper::Resource

  property :id,             Serial
  property :username,       String
  property :password,       String
  property :email_address,  String
end
