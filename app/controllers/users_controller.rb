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
      flash.keep[:success] = "Welcome to CF Services!"
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