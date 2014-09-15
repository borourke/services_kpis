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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project Updated!"
      redirect_to root_path
    else
      flash[:failure] = "Oooops! Something Went Wrong."
    end
  end

  def team_charts
    @user = current_user
    @business_data_chart_arrays = Project.biz_data_project_chart_arrays
    @content_gen_chart_arrays = Project.content_gen_project_chart_arrays
  end

	def create
		@project = Project.new(project_params)
    	if @project.save
    	  flash.keep[:success] = "New Project Created!"
    	  redirect_to new_report_card_path(project_name: params[:project][:project_name])
    	else
    	  render 'new_project'
    	end
	end

	private

		def project_params
      		params.require(:project).permit(:project_name, :project_type, :delivery_date, :hours,
                                   :spoilage, :project_number, :sla_accuracy, :accuracy, :user_id, :team, :complexity)
    	end

end