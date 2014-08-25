class ProjectsController < ApplicationController
	before_action :signed_in_user

	def new_project
    	if signed_in?
		   @project = Project.new
    	else
    	  render 'sign_up'
    	end
	end

  def show
    @projects = Project.all
  end

  def team_charts
    @user = current_user
    @business_data_chart_arrays = Project.biz_data_project_chart_arrays
    @content_gen_chart_arrays = Project.content_gen_project_chart_arrays
  end

	def create
		@project = Project.new(user_params)
    	if @project.save
    	  flash.now[:success] = "New Report Card Created!"
    	  redirect_to new_report_card_path
    	else
    	  render 'sign_up'
    	end
	end

	private

		def user_params
      		params.require(:project).permit(:project_name, :project_type, :delivery_date, :hours,
                                   :spoilage, :project_number, :sla_accuracy, :accuracy, :user_id, :team)
    	end

end