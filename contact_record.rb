class ContactRecord
	include DataMapper::Resource

	property :id,			Serial
	property :company,		String
	property :person,		String
	property :details,		Text
	property :contact_record_type,	String

	def self.contact_record_types
		@@contact_record_types
	end


	private
	
	@@contact_record_types = ["call received", "call made", "email sent", "email receive"]
end
