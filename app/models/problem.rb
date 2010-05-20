class Problem
	include DataMapper::Resource

	property :id,				Serial
	property :title,			String
	property :description,		Text
	property :company_name,		String
	property :company_web_site,	String
	property :company_phone,	String
	property :company_email,	String
	property :company_fax,		String
end
