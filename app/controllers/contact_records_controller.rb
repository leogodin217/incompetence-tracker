class ContactRecordsController < ApplicationController
	def index
		
	end
		
	def new
		@contact_record = ContactRecord.new
		@contact_record_types = ContactRecord.contact_record_types
	end

	def create
		@contact_record = ContactRecord.new(params[:contact_record])	

		if @contact_record.save
			flash[:notice] = 'Contact Record created'
			redirect_to contact_records_path
		else
			render :new
		end
	end
end
