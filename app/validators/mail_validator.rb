class MailValidator < ActiveModel::EachValidator

	def validate_each(record,attribute,value)
		unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
			record.errors[attribute]<<(options[:message] || "is not a mail address")
		end

	end

end
