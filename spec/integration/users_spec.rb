require File.dirname(__FILE__) + '/../spec_helper'

describe 'Guest visits home page' do
  it "should see home page"  do
    visit root_path
    response.should contain "Welcome to the Incompetence Tracker"
  end

  it "can create account" do
    User.count.should == 0
    visit root_path
    click_link 'Signup'
    fill_in 'Username', :with => "myuser"
    fill_in 'Password', :with => "mypass"
    fill_in 'Email',    :with => "mymail"
    click_button 'Signup'

    User.count.should == 1
  end

  it "requires username, password, and email address to create an account" do
    User.create(:password => "mypass", :email_address => "me@you.com").should_not be_valid
    User.create(:username => "mypass", :email_address => "me@you.com").should_not be_valid
    User.create(:password => "mypass", :password => "mypass").should_not be_valid

  end

  it "can login and logout" do
    visit root_path
    response.should have_selector 'a', :href => login_path

    @user = User.create(:username => 'user1', :password => 'mypassword', :email_address => 'leogodin217@gmail.com')
  
  
    click_link 'Login'
    fill_in 'Username', :with  => 'user1'
    fill_in 'Password', :with => 'mypassword'
    click_button 'Login'
    
    response.should contain 'user1 is logged in'

    click_link "logout"
    
    response.should have_selector 'a', :href => login_path
  end

  it "should fail with invalid username" do
    @user = User.create(:username => 'user1', :password => 'mypassword', :email_address => 'leogodin217@gmail.com')

    visit root_path
    click_link 'Login'
    fill_in 'Username', :with  => 'anotheruser1'
    fill_in 'Password', :with => 'mypassword'
    click_button 'Login'

    response.should contain("Login Failed")
  end


  it "should fail with invalid password" do
    @user = User.create(:username => 'user1', :password => 'mypassword', :email_address => 'leogodin217@gmail.com')

    visit root_path
    click_link 'Login'
    fill_in 'Username', :with  => 'user1'
    fill_in 'Password', :with => 'myotherpassword'
    click_button 'Login'

    response.should contain("Login Failed")
  end
end
