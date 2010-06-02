class ProblemsController < ApplicationController
	
	def index
		@problems = Problem.all
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
		@contact_record = ContactRecord.get params[:contact_record]
		unless session[:logged_in_user] == @problem.user_id
			flash[:notice] = 'You may only view your own Problems'
			redirect_to problems_path
		end

		@problem.contact_records << @contact_record

		if @problem.save
			redirect_to problem_path @problem.id
		else
			flash[:notice] = 'Could not associate Contact Record'
			render :associate_contact_record
		end
	end

end
