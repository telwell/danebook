module UsersHelper
	
	# Create an array of months and their associated values.
	def create_months_collection
		months = [['-', '']]
		(1..12).each {|m| months << [Date::MONTHNAMES[m], m]}
		# Don't return the first item of the array which is just nil anyway.
		months[1..-1]	
	end

end