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

  def project_charts
    @user = User.find(params[:id])
    @project_chart_arrays = @user.project_chart_arrays
  end

  def report_card_charts
    @user = User.find(current_user.id)
    @report_cards = ReportCard.where user_id: current_user.id
    tooltips = {"CML1" => "CML - clear and coherent structure", "CML2" => "CML - commented clearly", "Tags1" => "Tags - at least 5 in job", "Code1" => "Code - clean and re-usable", "Code2" => "Code - scripted solution utilized if more efficient", "Code3" => "Code - advanced scripting utilized", "Instructions1" => "Instructions - clear and concise", "Delivery1" => "Delivery - on or before agreed upon deadline", "Delivery2" => "Delivery - all client docs completed", "Com1" => "Communication - clear, professional AS and Sales communication", "Accuracy1" => "Accuracy - at or above client expectations", "Spoilage1" => "Spoilage - low spoilage, high yield", "Project1" => "Project - complex, innovative problem solving", "Bronze1" => "Bronze - best in class", "Silver1" => "Silver - best in class", "Gold1" => "Gold - Best in class"}

    #Create array for report cards chart by counting every instance of the report card category
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
    final_rarray = []
    counting_hash.each do |x|
      name = x[0]
      count = x[1]
      tooltip = tooltips[name]
      final_rarray << [name, count, tooltip]
    end
    @final_hash = final_rarray

    #Create array of project name and count of total points on report card
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
      sign_in @user      
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