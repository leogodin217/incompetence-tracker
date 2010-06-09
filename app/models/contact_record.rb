class ContactRecord
	include DataMapper::Resource

	property :id,					Serial
	property :company, 				String
    property :person,				String	
	property :details,				Text
	property :contact_record_type,	String
	property :created_at,			DateTime
	property :user_id,				Integer

	belongs_to :user
	has 1, :problem, :through => Resource

	def select_option_display
		return "#{company} - #{created_at.strftime "%A %m/%d/%y %H:%M"} - #{contact_record_type}"
	end
	
	def self.contact_record_types
		@@contact_record_types
	end

	def self.my_contact_records(user_id)
		return ContactRecord.all :user_id => user_id
	end


	private
	
	@@contact_record_types = ["call made", "call received", "email sent", "email received"]
end
