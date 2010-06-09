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

		response.should contain('Another Company')
		response.should contain('A Company')
		response.should contain('A Different Company')
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

	it 'requires a login to view contact_records' do
		User.create(:username 	   => 'myuser',
					:password 	   => 'mypassword',
					:email_address => 'me@you.com',
				    :id 		   => '1')

		ContactRecord.create(:user_id 			  => 1,
						 	 :company 			  => 'a company',
							 :person  			  => 'a person',
							 :details 			  => 'some details',
							 :contact_record_type => 'email sent')

		visit contact_records_path
		response.should contain 'You must be logged in to access this feature'
		
		fill_in 'username', :with => 'myuser'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		visit contact_records_path

		response.should_not contain 'You must be logged in to access this feature'
	end

	it 'requires a login to create contact records' do

		User.create(:username 		=> 'myuser',
					:password 		=> 'mypassword',
					:email_address  => 'me@you.com')

		visit new_contact_record_path

		response.should contain 'You must be logged in to access this feature'

		fill_in 'username', :with => 'myuser'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		visit new_contact_record_path

		response.should_not contain 'You must be logged in to access this feature'	
	end

	it 'only allows Contact Record owner to view Contact Record' do
		User.create :username 		=> 'somedude',
					:password 		=> 'mypassword',
					:email_address  => 'somedude@you.com'

		@owner = User.create :username 		=> 'myuser',
							 :password 		=> 'mypassword',
							 :email_address  => 'me@you.com'

		@owner.contact_records.create :company 	=> 'some company',
				             		  :person    => 'some person',
							 		  :details   => 'some details of a contact record'

		visit root_path
		click_link 'login'	
		fill_in 'username', :with => 'somedude'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		visit contact_record_path(1)

		response.should contain 'You may only view your own Contact Records'

		visit root_path
		click_link 'logout'
		click_link 'login'	
		fill_in 'username', :with => 'myuser'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		visit contact_record_path(1)

		response.should contain 'some details of a contact record'


	end

end
