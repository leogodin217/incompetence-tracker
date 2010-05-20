class ProblemsController < ApplicationController
	
	def new
		@problem = Problem.new
	end

	def create
		@problem = Problem.new params[:problem]
		if @problem.save
			flash[:notice] = 'Problem successfully created'
			redirect_to problem_path @problem
		else
			render :new
		end
	end

	def show
		@problem = Problem.get params[:id]
	end
end
