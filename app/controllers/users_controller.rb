class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @tasks_grid = initialize_grid(ReportCard, conditions: {:user_id => params[:id]}, :include => [:project])
    @report_cards = ReportCard.where user_id: params[:id]
    @project_ids = @report_cards.collect { |x| x.project_id }
    @projects = Project.find(@project_ids)
  end

  def my_projects
    @user = User.find(params[:id])
    report_cards = ReportCard.where(user_id: @user.id)
    @projects = []
    project_ids = []
    report_cards.each do |report_card|
      project_ids << report_card.project_id
    end
    project_ids.uniq!
    project_ids.each do |project_id|
      @projects << Project.find(project_id)
    end
    @project_chart_arrays = @user.project_chart_arrays
  end

  def my_report_cards
    @user = User.find(params[:id])
    report_cards = ReportCard.where(user_id: @user.id)
    @tables = []
    report_cards.each do |report_card|
      dummy_hash = {}
      project = Project.find(report_card.project_id)
      dummy_hash["project_name"] = project.project_name
      job_score = [report_card.cml_clean, report_card.cml_commented, report_card.instructions, report_card.tags].compact
      job_score.reject! {|x| ((x=="na") || (x=="no"))}
      job_score = job_score.join(", ")
      dummy_hash["job_score"] = job_score
      technical_score = [report_card.code_clean, report_card.code_utilized, report_card.code_advanced, report_card.complex_solution].compact
      technical_score.reject! {|x| ((x=="na") || (x=="no"))}
      technical_score = technical_score.join(", ")
      dummy_hash["technical_score"] = technical_score
      delivery_score = [report_card.delivery_timely, report_card.delivery_docs, report_card.communication, report_card.accuracy, report_card.spoilage].compact
      delivery_score.reject! {|x| ((x=="na") || (x=="no"))}
      delivery_score = delivery_score.join(", ")
      dummy_hash["delivery_score"] = delivery_score
      dummy_hash["overall_score"] = report_card.best_in_class
      if (report_card.best_in_class != "no") && (report_card.best_in_class != "na") 
        best_in_class_points = 1 
      else 
        best_in_class_points = 0 
      end
      dummy_hash["points"] = job_score.split(", ").length + technical_score.split(", ").length + delivery_score.split(", ").length
      @tables << dummy_hash
    end
    @report_cards_array = @user.report_card_chart_arrays
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def sign_up
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user      
      flash.now[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'sign_up'
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :team, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to sign_in_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end