class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
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
    @report_cards_array = @user.report_card_tables_arrays
    @report_cards_charts = User.report_card_charts(current_user.id)
    @medals_array = Service.get_medal_count(current_user)
    @my_medals_month_hash = Service.get_medals_by_month(@user.id)
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
    p '*' *300
    p params
    p user_params
    p '*' *300
    @user = User.new(user_params)
    if @user.save
      sign_in @user      
      flash.keep[:success] = "Welcome to CF Services!"
      redirect_to @user
    else
      redirect_to '/sign_up'
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
        redirect_to sign_in_url, notice: "Please sign in, or create a new account."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end