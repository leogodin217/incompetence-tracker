class ContactRecordsController < ApplicationController
	def index
		@user = User.get(session[:logged_in_user])
		@contact_records = @user.my_contact_records
	end
		
	def new
		@contact_record = ContactRecord.new
		@contact_record_types = ContactRecord.contact_record_types
	end

	def create
		@contact_record = ContactRecord.new(params[:contact_record])	
		@contact_record.user_id = session[:logged_in_user]

		if @contact_record.save
			flash[:notice] = 'Contact Record created'
			redirect_to contact_records_path
		else
			render :new
		end
	end

	def show
		@user = User.get(session[:logged_in_user])
		@contact_record = ContactRecord.get(params[:id])
		
		unless @user.id == @contact_record.user_id
			flash[:notice] = 'You may only view your own Contact Records'
			redirect_to contact_records_path
		end
	end
end
