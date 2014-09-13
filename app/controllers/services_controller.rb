class ServicesController < ApplicationController
	before_action :signed_in_user
	
	def home
		@medals_array = Service.get_medal_count(current_user)
		@medals_count_all_time = Service.get_all_time_medal_count
		@this_months_happiness_average = HappinessSurvey.this_months_avg_happiness
		@medals_month_hash = Service.get_medals_by_month
	end

end