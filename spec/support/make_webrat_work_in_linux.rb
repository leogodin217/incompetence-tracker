require 'webrat'

module Webrat::SaveAndOpenPage
  alias_method :old_open_in_browser, :open_in_browser
 
  def open_in_browser(path)
    if ruby_platform =~ /linux/i
      `chromium-browser #{path}`
    else
      old_open_in_browser path
    end 
  end
end
