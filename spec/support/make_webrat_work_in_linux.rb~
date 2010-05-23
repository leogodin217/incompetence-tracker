require 'webrat'

module Webrat::SaveAndOpenPage
  alias_method :old_open_in_browser, :open_in_browser
 
  def open_in_browser(path)
    if RUBY_PLATFORM =~ /linux/i
    #if ruby_platform =~ /linux/i
      `google-chrome #{path}`
    else
      old_open_in_browser path
    end 
  end
end
