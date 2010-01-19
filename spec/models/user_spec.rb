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

  it "fails with non unique username" do
    @user1 = User.create :username => "myname", :password => "somepassword", :email_address => "me@you.com"
    User.create(:username => "myname", :password => "somepassword", :email_address => "foo@you.com").should_not be_valid
  end

  it "fails with non unique password" do
    @user1 = User.create :username => "myname", :password => "somepassword", :email_address => "me@you.com"
    User.create(:username => "foo", :password => "somepassword", :email_address => "me@you.com").should_not be_valid
  end
end
