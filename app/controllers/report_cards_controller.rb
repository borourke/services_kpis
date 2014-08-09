class ReportCardsController < ApplicationController
	before_action :signed_in_user

	def new_report_card
    if signed_in?
		  @report_card = ReportCard.new
    else
      render root_path
    end
	end

end