require File.dirname(__FILE__) + '/../spec_helper'
require 'spec/factories'

describe Problem do
	it 'can create a Problem' do 
		Problem.all.should be_empty

		User.create :username => 'myuser',
					:password => 'mypassword',
					:email_address => 'myuser@localhost.com'


		visit root_path
		click_link  	'login'
		fill_in 		'username', 	:with => 'myuser'
		fill_in 		'password', 	:with => 'mypassword'
		click_button 	'login'

		# Non required fields go first then check for each required field
		click_link		'New Problem'
		fill_in			'problem_company_phone',	:with => '867-5309'
		fill_in			'problem_company_email',	:with => 'nohelp@stupidco.com'
		fill_in			'problem_company_fax',		:with => '867-5309'
		fill_in			'problem_company_web_site', :with => 'www.stupidco.com.stu.pid.co'
		click_button	'Create'
		response.should contain 'Could not create Problem'
		fill_in			'problem_title', 			:with => 'I got a problem man!'
		click_button	'Create'
		response.should contain 'Could not create Problem'
		fill_in			'problem_company_name', 	:with => 'some stupid company'
		click_button	'Create'
		response.should contain 'Could not create Problem'
		fill_in			'problem_description',		:with => 'A really long way to say I been wronged man!'
		click_button	'Create'

		response.should contain 'Problem successfully created'
		Problem.all.length.should == 1
	end

	it 'can view a problem' do
		:user.gen
		visit 			root_path
		click_link 		'login'
		fill_in 		'username', 	:with => 'myuser'
		fill_in 		'password', 	:with => 'mypassword'
		click_button 	'login'

		@problem = :problem.gen :title 				=> 'This is a problem',
								:description		=> 'A problem description',
								:company_name		=> 'my company',
								:company_web_site	=> 'www.myco.com',
								:company_phone		=> '555-555-5555',
								:company_email 		=> 'me@you.com',
								:company_fax		=> '555-555-5556',
								:user_id			=> '1'


		visit problem_path @problem.id
		response.should contain 'Viewing Problem'		
		response.should contain 'This is a problem'
		response.should contain 'A problem description'
		response.should contain 'my company'
		response.should contain 'www.myco.com'
		response.should contain '555-555-5555'
		response.should contain '555-555-5556'
	end

	it 'can view all problems' do

		:user.gen
		visit 			root_path
		click_link 		'login'
		fill_in 		'username', 	:with => 'myuser'
		fill_in 		'password', 	:with => 'mypassword'
		click_button 	'login'

		:problem.gen :title => 'my problem', 	:user_id => '1'
		:problem.gen :title => 'a problem', 	:user_id => '1'
		:problem.gen :title => 'big problem', 	:user_id => '1'

		visit problems_path

		response.should contain 'my problem'
		response.should contain 'a problem'
		response.should contain 'big problem'
	end

	it 'can associate contact records with a problem' do
		do_login
		@problem 		 = :problem.gen :user_id => '1'
		@contact_record  = :contact_record.gen :company => 'record 1', :user_id => '1'
		@contact_record1 = :contact_record.gen :company => 'record 2', :user_id => '1'	

		@problem.contact_records.should be_empty

		visit problem_path @problem.id
		click_link 'Associate Contact Record'
		select  /record 1/
		click_button 'Save'
		click_link 'Associate Contact Record'
		select  /record 2/
		click_button 'Save'
	
		@problem.reload	
		@problem.contact_records.length.should == 2	

	end

	it 'can view contact records for a problem' do
		do_login
		@problem 		 = :problem.gen :user_id => '1'
		@contact_record  = :contact_record.gen :company => 'record 1', :user_id => '1'
		@contact_record1 = :contact_record.gen :company => 'record 2', :user_id => '1'	
		@problem.contact_records << @contact_record
		@problem.contact_records << @contact_record1
		@problem.save
		
		@problem.contact_records.length.should == 2
		visit problem_path @problem.id
		response.should contain 'record 1'
		response.should contain 'record 2'
	end

	it 'requires a login to create a problem' do
		@problem = :problem.gen :title => 'My problem', :user_id => '1'

		visit problem_path @problem.id

		response.should contain 'You must be logged in to access this feature'
		
		do_login

		visit problem_path @problem.id
		
		response.should_not contain 'You must be logged in to access this feature'
		response.should contain 'My problem'
	end

	it 'requires a login to create a problem' do
		visit new_problem_path

		response.should contain 'You must be logged in to access this feature'
		
		do_login

		visit new_problem_path		

		response.should_not contain 'You must be logged in to access this feature'
	end

	it 'makes problems private by default' do
		User.create :username => 'owner', 
					:password => 'mypassword', 
					:email_address => 'owner@localhost.com'

		User.create :username => 'viewer', 
					:password => 'mypassword', 
					:email_address => 'viewer@localhost.com'

		@problem = :problem.gen :user_id => 1, :title => 'My Problem'

		visit root_path
		click_link 'login'
		fill_in 'username', :with => 'viewer'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'
		
		visit problem_path @problem.id

		response.should contain 'You may only view your own Problems'

		visit root_path
		click_link 'logout'
		click_link 'login'
		fill_in 'username', :with => 'owner'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		visit problem_path @problem.id

		response.should_not contain 'You may only view your own Problems'
		response.should contain 	'My Problem'
	end

	it 'shows my problems only' do

		User.create :username => 'owner', 
					:password => 'mypassword', 
					:email_address => 'owner@localhost.com'

		User.create :username => 'viewer', 
					:password => 'mypassword', 
					:email_address => 'viewer@localhost.com'

		:problem.gen :title => 'owners problem', :user_id => '1'
		:problem.gen :title => 'owners other problem', :user_id => '1'
		:problem.gen :title => 'viewers  problem', :user_id => '2'

		visit root_path
		click_link 'login'
		fill_in 'username', :with => 'viewer'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		click_link 'My Problems'
		response.should 	contain 'viewers problem'
		response.should_not contain 'owners problem'
		response.should_not contain 'owners other problem'

		visit root_path
		click_link 'logout'
		click_link 'login'
		fill_in 'username', :with => 'owner'
		fill_in 'password', :with => 'mypassword'
		click_button 'login'

		click_link 'My Problems'
		response.should_not contain 'viewers problem'
		response.should 	contain 'owners problem'
		response.should 	contain 'owners other problem'
	end

	it 'can print a problem' do
		@problem = Problem.gen :title 	=> 'This is a problem',
							   :description 			=> 'This is a problem description',
							   :company_name 			=> 'This is a company',
							   :company_web_site	=> 'www.thisisacompany.com',
							   :company_phone			=> '555-555-5555',
							   :company_email			=> 'me@thisisacompany.com',
							   :company_fax				=> '555-555-5556',
							   :user_id						=> 1

		@first_contact_time = Time.now
	    @contact_record = ContactRecord.gen :company 				=> 'cr This is a company',
							  				:person  							=> 'Some dude',
							  				:details 							=> 'These are details',
							  				:contact_record_type 	=> 'call made',
							  				:created_at						=> @first_contact_time,
												:user_id 							=> 1

		@second_contact_time = Time.now + 60*60*24
	    @contact_record2 = ContactRecord.gen :company				=> 'cr This is company',
							  				:person 				=> 'Some other dude',
							  				:details 				=> 'These are other details',
							  				:contact_record_type 	=> 'call received',
							  				:created_at				=> @second_contact_time
			@problem.contact_records << @contact_record
			@problem.contact_records << @contact_record2
			@problem.save
		
		do_login
		visit problem_path @problem.id
		click_link 'Print Problem'
		response.should contain 'This is a problem'
		response.should contain 'This is a problem description'
		response.should contain 'This is a company'
		response.should contain 'www.thisisacompany.com'
		response.should contain '555-555-5555'
		response.should contain 'me@thisisacompany.com'
		response.should contain '555-555-5556'
		response.should contain @first_contact_time.strftime("%m/%d/%Y %I:%m %p")
		response.should contain @second_contact_time.strftime("%m/%d/%Y %I:%m %p")
		response.should contain 'Some other dude'
		response.should contain 'Some dude'
		response.should contain 'These are other details'
		response.should contain 'These are details'
		response.should contain 'call made'
		response.should contain 'call received'
							 
	end

	it 'can make a Problem public' do
		@problem = :problem.gen :title => 'this is a problem', :user_id => 1
		@problem.is_public.should be_false

		visit root_path
		response.should_not contain 'this is a problem'
		do_login

		visit problem_path @problem.id
		click_link 'Make Public'
		click_link 'Continue'
		@problem.reload
		@problem.is_public.should be_true
		response.should contain 'Problem is now public'
		visit root_path

		response.should contain 'this is a problem'
	end
end
