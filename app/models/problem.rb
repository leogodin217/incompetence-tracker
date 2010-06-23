class Problem
	include DataMapper::Resource

	property :id,				Serial
	property :title,			String,		:required => true
	property :description,		Text,		:required => true
	property :company_name,		String,		:required => true
	property :company_web_site,	String
	property :company_phone,	String
	property :company_email,	String
	property :company_fax,		String
	property :user_id,			Integer
	property :is_public,		Boolean,	:default => false

	has n, :contact_records, :through => Resource
	belongs_to :user

	def self.my_problems(user_id) 
		return Problem.all :user_id => user_id
	end

	def associate_contact_record(contact_record_id)
		ContactRecordProblem.create(:problem_id => id, :contact_record_id => contact_record_id) unless ContactRecordProblem.first(:problem_id => id, :contact_record_id => contact_record_id).present? 
	end
end
