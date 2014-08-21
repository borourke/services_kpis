class ReportCardsController < ApplicationController
	before_action :signed_in_user
  autocomplete :user, :name

	def new_report_card
	   @report_card = ReportCard.new
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
      		params.require(:report_card).permit(:project_id, :type, :user_id, :cml_clean, :cml_commented, :instructions, :tags, :code_clean, :code_utilized, :code_advanced, :delivery_timely, :delivery_docs, :communication, :accuracy, :spoilage, :complex_solution, :best_in_class, :job_score, :delivery_score, :technical_score, :overall_score)
    	end

end