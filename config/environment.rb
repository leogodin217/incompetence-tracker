require 'rubygems'
# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'haml'        
  config.gem 'datamapper'  
  config.gem 'rails_datamapper'
  config.gem 'data_objects'

  config.frameworks -= [:active_record]

  config.time_zone = 'UTC'

  require File.join(RAILS_ROOT, 'lib/extensions')
end

Haml.init_rails(binding)

#require File.join(Rails.root, '/lib/datamapper_extensions')
