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

		@problem = :problem.gen :title 			=> 'This is a problem',
								:description	=> 'A problem description',
								:company_name	=> 'my company'


		visit problem_path @problem.id
		response.should contain 'Viewing Problem'		
		response.should contain 'This is a problem'
		response.should contain 'A problem description'
		response.should contain 'my company'

	end




end
