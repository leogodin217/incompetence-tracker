require 'factory_girl'
require 'factory_girl_extensions'

Factory.define :user do |o|
	o.username 		'myuser'
	o.password		'mypassword'
	o.email_address	'me@you.com'
end
