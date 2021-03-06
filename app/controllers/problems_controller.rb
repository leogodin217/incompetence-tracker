class ProblemsController < ApplicationController
	
	def index
		@problems = Problem.my_problems session[:logged_in_user]
	end

	def new
		@problem = Problem.new
	end

	def create
		@problem = Problem.new params[:problem]
		@problem.user_id = session[:logged_in_user]
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
		unless session[:logged_in_user] == @problem.user_id
			flash[:notice] = 'You may only view your own Problems'
			redirect_to problems_path
		end
	end

	def associate_contact_record
		@problem = Problem.get params[:id]
		@contact_records = ContactRecord.my_contact_records session[:logged_in_user]
		unless session[:logged_in_user] == @problem.user_id
			flash[:notice] = 'You may only view your own Problems'
			redirect_to problems_path
		end
	end

	def save_contact_record_association
		@problem = Problem.get params[:id]

		unless session[:logged_in_user] == @problem.user_id
			flash[:notice] = 'You may only view your own Problems'
			redirect_to problems_path
		end
		
		@problem.associate_contact_record params[:contact_record]
		redirect_to problem_path @problem.id
	end

	def print
		@problem = Problem.get params[:id]
	end

	def make_public
		@problem = Problem.get params[:id]
	end

	def save_public
		@problem = Problem.get params[:id]
		@problem.is_public = true
		if @problem.save
						flash[:notice] = 'Problem is now public'
		else
						flash[:notice] = 'Cannot make problem public'
		end
		redirect_to problem_path @problem.id
	end
end
