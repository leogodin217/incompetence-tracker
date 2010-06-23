class HomePageController < ApplicationController
  def home_page_index
		@problems = Problem.all(:is_public => true)
  end
end
