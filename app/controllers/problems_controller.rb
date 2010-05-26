class ProblemsController < ApplicationController
	
	def new
		@problem = Problem.new
	end

	def create
		@problem = Problem.new params[:problem]
		if @problem.save
			flash[:notice] = 'Problem successfully created'
			redirect_to problem_path @problem.id
		else
			flash[:notice] = 'Could not create Problem'
			render :new
		end
	end

	def show
		@problem = Problem.get params[:id]
	end
end
