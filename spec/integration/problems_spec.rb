require File.dirname(__FILE__) + '/../spec_helper'
require 'spec/factories'

describe Problem do
	it 'can create a Problem' do 
		Problem.all.should be_empty

		User.create :username		=> 'myuser',
					:password		=> 'mypassword',
					:email_address 	=> 'myuser@leogodin.net'


		visit root_path
		save_and_open_page
		click_link  	'login'
		save_and_open_page
		fill_in 		'username', 	:with => 'myuser'
		fill_in 		'password', 	:with => 'mypassword'

		click_button 	'login'
		save_and_open_page
		click_link		'New Problem'
		fill_in			'problem_title', 			:with => 'I got a problem man!'
		fill_in			'problem_company_name', 	:with => 'some stupid company'
		fill_in			'problem_company_web_site', :with => 'www.stupidco.com.stu.pid.co'
		fill_in			'problem_company_phone',	:with => '867-5309'
		fill_in			'problem_company_email',	:with => 'nohelp@stupidco.com'
		fill_in			'problem_company_fax',		:with => '867-5309'
		fill_in			'problem_description',		:with => 'A really long way to say I been wronged man!'
		click_button	'Create'

		response.should contain 'Problem successfully created'
		Problem.all.length.should == 1
	end

	it 'can view a problem'




end
