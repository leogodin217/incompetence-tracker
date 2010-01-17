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
  it "should do foo"
end
