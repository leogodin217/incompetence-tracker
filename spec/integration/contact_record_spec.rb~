require File.dirname(__FILE__) + '/../spec_helper'

describe ContactRecord do 
	it "can create a contact_record" do
		ContactRecord.all.should be_empty

		User.create :username => 'myuser', :password => 'mypassword', :email_address => 'me@you.com'

		visit 			root_path
		click_link 		'Login'
		fill_in			'username', 	:with => 'myuser'
		fill_in			'password', 	:with => 'mypassword'
		click_button	'Login'	
		click_link		'new contact record'
		fill_in 		'company', 		:with => 'Some Company'
		fill_in			'person',		:with => 'Some Person'
		fill_in			'details',		:with => 'Talked to someone and said things but disagreed'
		select			'call made'
		click_button	'Create'

		response.should contain 'Contact Record created'
		ContactRecord.all.should_not be_empty
	end

end
