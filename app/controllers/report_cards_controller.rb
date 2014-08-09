class ReportCardsController < ApplicationController
	before_action :signed_in_user

	def new_report_card
    	if signed_in?
			  @report_card = ReportCard.new
    	else
    	  render root_path
    	end
	end

	def show
        @tasks_grid = initialize_grid(ReportCard)
	end

	def create
		@report_card = ReportCard.new(report_card_params)
    	if @report_card.save
    	  flash.now[:success] = "New Report Card Created!"
    	  redirect_to root_path
    	else
    	  render 'sign_up'
    	end
    end

    private

		def report_card_params
            report = params[:report_card][:report_card].reject { |x| x.empty? }
            params[:report_card][:report_card] = report.join(", ")
      		params.require(:report_card).permit(:project_id, :type, :user_id, :report_card)
    	end

end