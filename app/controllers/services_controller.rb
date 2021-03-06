class ServicesController < ApplicationController
	before_action :signed_in_user
	
	def home
		@user = current_user
		@medals_count_all_time = Service.get_all_time_medal_count
		@this_months_happiness_average = HappinessSurvey.this_months_avg_happiness
		@medals_month_hash = Service.get_medals_by_month("all")
		@my_medals_month_hash = Service.get_medals_by_month(@user.id)
		@happiness_by_month = HappinessSurvey.all_users_happiness_through_time
		@happiness_by_category = HappinessSurvey.all_users_happiness_by_category_by_month
		@happiness_distributions_by_category = HappinessSurvey.happiness_distributions_by_month
		@medals_array = Service.get_medal_count(current_user)
		@report_cards_charts = User.report_card_charts(current_user.id)
		@all_report_cards_charts = User.report_card_charts("all")
	end

end