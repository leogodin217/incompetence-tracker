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

	has n, :contact_records, :through => Resource
	belongs_to :user
end
