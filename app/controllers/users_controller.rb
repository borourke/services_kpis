class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @tasks_grid = initialize_grid(ReportCard, conditions: {:user_id => params[:id]})
    @report_cards = ReportCard.where user_id: params[:id]
    @project_ids = @report_cards.collect { |x| x.project_id }
    @projects = Project.find(@project_ids)
    @tasks_grid2 = initialize_grid(Project)
  end

  def report_card_charts
    @user = User.find(current_user.id)
    @report_cards = ReportCard.where user_id: current_user.id

    #Create hash for report cards chart by counting every instance of the report card category
    report_cards_array = @report_cards.collect { |x| x.report_card }
    report_cards_array.reject! { |x| x.nil? }
    rarray = []
    report_cards_array.each do |x|
      dummy = x.split(", ")
      dummy.each do |y|
        rarray << y
      end
    end
    counting_hash = Hash.new 0
    rarray.each do |g|
      counting_hash[g] += 1
    end
    counting_hash = counting_hash.sort_by {|k, v| v}
    @final_hash = counting_hash

    #Create hash of project name and count of total points on report card
    projects_array = @report_cards.collect { |x| [x.report_card, x.project_id] }
    projects_array.reject! { |x| x[0].nil? }
    projects_array.each_with_index do |x, i|
      dummy = []
      pid = x[1]
      r = x[0]
      dummy = r.split(', ')
      projects_array[i][1] = dummy.length
      project = Project.find(pid)
      projects_array[i][0] = project.project_name
    end
    @final_array = projects_array
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
      flash.now[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'sign_up'
    end
  end

  private

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