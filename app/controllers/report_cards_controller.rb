class ReportCardsController < ApplicationController
	before_action :signed_in_user

  def edit
    @report_card = ReportCard.find(params[:id])
    @services_members = ReportCard.get_all_services_members
    @project_names = ReportCard.get_all_project_names
    @project_name = @report_card.project_name
  end

  def update
    @report_card = ReportCard.find(params[:id])
    if @report_card.update_attributes(report_card_params)
      flash[:success] = "Report Card Updated"
      redirect_to root_path
    else
      flash[:failure] = "Oooops! Something Went Wrong."
    end
  end

  def new
    @report_card = ReportCard.new
    @project_name = params[:project_name]
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
    @report_card_tables = ReportCard.generate_report_card_admin_tables
  end

  def create
    @report_card = ReportCard.new(report_card_params)
    if @report_card.save(report_card_params)
      flash.keep[:success] = "New Report Card Created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def report_card_params
    user = User.where(name: params[:report_card][:user_name])
    project = Project.where(project_name: params[:report_card][:project_name])
    params[:report_card][:project_id] = project.first.id
    params[:report_card][:user_id] = user.first.id
    params.require(:report_card).permit(:project_id, :user_id, :job_score, :project_score, :technical_score, :efficiency_score, :user_name, :project_name, :comments, :job_array => [], :project_array => [], :technical_array => [])
  end

end