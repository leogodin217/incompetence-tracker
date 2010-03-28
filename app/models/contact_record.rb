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

	def self.contact_record_types
		@@contact_record_types
	end

	private
	
	@@contact_record_types = ["call made", "call received", "email sent", "email received"]
end