class ProblemsController < ApplicationController
	
	def index
		@problems = Problem.all
	end

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

	def associate_contact_record
		@problem = Problem.get params[:id]
		@contact_records = ContactRecord.my_contact_records session[:logged_in_user]
	end

	def save_contact_record_association
		@problem = Problem.get params[:id]
		@contact_record = ContactRecord.get params[:contact_record]

		@problem.contact_records << @contact_record

		if @problem.save
			redirect_to problem_path @problem.id
		else
			flash[:notice] = 'Could not associate Contact Record'
			render :associate_contact_record
		end
	end

end
