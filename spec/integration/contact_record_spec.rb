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
		@contact = ContactRecord.first
		@contact.created_at.should_not be_blank
	end
	
	it "can view my contact records" do
		ContactRecord.all.should be_empty

		@user = User.create :username => 'myuser', :password => 'mypassword', :email_address => 'me@you.com'
		@user.contact_records.create(:company => 'Another Company',
							 		 :person  => 'Another Person',
							 		 :details => 'We also talked about stuff')
		@user.contact_records.create(:company => 'A Company',
							 		 :person  => 'A Person',
							 		 :details => 'We talked about stuff')
		@user.contact_records.create(:company => 'A Different Company',
							 		 :person  => 'A Different Person',
							 		 :details => 'We intended to talked about stuff')
		@user.my_contact_records.length.should == 3

		visit root_path
		click_link 		'Login'
		fill_in			'username', 	:with => 'myuser'
		fill_in			'password', 	:with => 'mypassword'
		click_button	'Login'	

		click_link 'My Contact Records'

		response.should contain('Contact Records: 3')
	end

	it "can view a contact record" do
		@user = User.create :username => 'myuser', :password => 'mypassword', :email_address => 'me@you.com'
		@contact_record = @user.contact_records.create(:company => 'Another Company',
							 		 				   :person  => 'Another Person',
							 		 				   :details => 'We also talked about stuff')

		visit root_path
		click_link		'Login'
		fill_in 		'username', 	:with => 'myuser'
		fill_in			'password',		:with => 'mypassword'
		click_button	'Login'

		visit contact_record_path(@contact_record.id)

		response.should contain 'Another Company'
		
	end



end
