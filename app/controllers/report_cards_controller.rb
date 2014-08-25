class ReportCardsController < ApplicationController
	before_action :signed_in_user

	def new_report_card
	 @report_card = ReportCard.new
    users = User.all
    @services_members = []
    users.each do |user|
      @services_members << user.name
    end
    projects = Project.all
    @project_names = []
    projects.each do |project|
      @project_names << project.project_name
    end
	end

    def show
      report_cards = ReportCard.all
      @tables = []
      report_cards.each do |report_card|
        dummy_hash = {}
        project = Project.find(report_card.project_id)
        dummy_hash["project_name"] = project.project_name
        job_score = [report_card.cml_clean, report_card.cml_commented, report_card.instructions, report_card.tags]. compact
        job_score.reject! {|x| ((x=="na") || (x=="no"))}
        job_score = job_score.join(", ")
        dummy_hash["job_score"] = job_score
        technical_score = [report_card.code_clean, report_card.code_utilized, report_card.code_advanced, report_card. complex_solution].compact
        technical_score.reject! {|x| ((x=="na") || (x=="no"))}
        technical_score = technical_score.join(", ")
        dummy_hash["technical_score"] = technical_score
        delivery_score = [report_card.delivery_timely, report_card.delivery_docs, report_card.communication,  report_card.accuracy, report_card.spoilage].compact
        delivery_score.reject! {|x| ((x=="na") || (x=="no"))}
        delivery_score = delivery_score.join(", ")
        dummy_hash["delivery_score"] = delivery_score
        dummy_hash["overall_score"] = report_card.best_in_class
        user = User.find(report_card.user_id)
        dummy_hash["services_member"] = user.name
        if (report_card.best_in_class != "no") && (report_card.best_in_class != "na") 
          best_in_class_points = 1 
        else 
          best_in_class_points = 0 
        end
        dummy_hash["points"] = job_score.split(", ").length + technical_score.split(", ").length + delivery_score.split(", ").length
        @tables << dummy_hash
      end
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
      user = User.where(name: params[:report_card][:user_name])
      project = Project.where(project_name: params[:report_card][:project_name])
      params[:report_card][:project_id] = project.first.id
      params[:report_card][:user_id] = user.first.id
      @name = params[:report_card][:user_name]
      @id = params[:report_card][:user_id]
      params.require(:report_card).permit(:project_id, :type, :user_id, :cml_clean, :cml_commented, :instructions, :tags, :code_clean, :code_utilized, :code_advanced, :delivery_timely, :delivery_docs, :communication, :accuracy, :spoilage, :complex_solution, :best_in_class, :job_score, :delivery_score, :technical_score, :overall_score, :user_name, :project_name, :comments)
    	end

end