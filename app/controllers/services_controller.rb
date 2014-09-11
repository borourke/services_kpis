class ServicesController < ApplicationController

	def home
		@medals_array = Service.get_medal_count(current_user)
	end

end