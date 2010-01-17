require File.dirname(__FILE__) + '/../spec_helper'

describe User, "Create" do
  
  it "authenticates with correct username and password"  do
    @user = User.create :username => "myname", :password => "somepassword", :email_address => "me@you.com"
    @user.authenticate({:username => "myname", :password => "somepassword"}).should be_true
  end

  it "fails with incorrect username " do
    @user = User.create :username => "myname", :password => "somepassword", :email_address => "me@you.com"
    @user.authenticate({:username => "myothername", :password => "somepassword"}).should be_false
  end

  it "fails with incorrect password" do
    @user = User.create :username => "myname", :password => "somepassword", :email_address => "me@you.com"
    @user.authenticate({:username => "myname", :password => "someotherpassword"}).should be_false
  end
    
end
