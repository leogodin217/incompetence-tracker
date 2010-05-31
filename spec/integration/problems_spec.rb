require File.dirname(__FILE__) + '/../spec_helper'
require 'spec/factories'

describe Problem do
	it 'can create a Problem' do 
		Problem.all.should be_empty

		:user.gen


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
								:company_fax		=> '555-555-5556'


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
		@problem 		 = :problem.gen
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
		@problem 		 = :problem.gen
		puts @probelm.inspect
		@contact_record  = :contact_record.gen :company => 'record 1', :user_id => '1'
		@contact_record1 = :contact_record.gen :company => 'record 2', :user_id => '1'	
		@problem.contact_records << @contact_record
		@problem.contact_records << @contact_record1
		@problem.save
		
		@problem.contact_records.length.should == 2
		puts @probelm.inspect
		visit problem_path @problem.id
		response.should contain 'record 1'
		response.should contain 'record 2'
	end
end
