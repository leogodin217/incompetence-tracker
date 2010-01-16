require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to ~/spec when you run 'ruby script/generate rspec'
  # from the project root directory.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'spec/autorun'
  require 'spec/rails'

  # Uncomment the next line to use webrat's matchers
  #require 'webrat/integrations/rspec-rails'
  
  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
  
  
  Webrat.configure do |config|
    config.mode = :rails
  end
  
  Spec::Runner.configure do |config|
    transactional_specs(config)
    #config.include(Webrat::Matchers, :type => [:integration])
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  
end
