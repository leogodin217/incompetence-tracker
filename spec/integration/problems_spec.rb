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

		:problem.gen :title => 'my problem'
		:problem.gen :title => 'a problem'
		:problem.gen :title => 'big problem'

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
		select  'record 1'
		click_button 'Save'
		click_link 'Associate Contact Record'
		select  'record 2'
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
		@problem = :problem.gen :title => 'My problem'

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
end
