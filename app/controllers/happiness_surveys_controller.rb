class HappinessSurveysController < ApplicationController
  before_action :signed_in_user

  def new
    @user = current_user
    @happiness_survey = HappinessSurvey.new
  end

  def show
    @happiness_by_month_hash = HappinessSurvey.user_happiness_through_time(current_user.id)
    @happiness_by_category = HappinessSurvey.user_happiness_by_category(current_user.id)
  end

  def index
  end

  def create
    @user = current_user
    happiness_survey_id = HappinessSurvey.check_if_survey_already_taken_for_this_month(@user.id)
    if happiness_survey_id.empty?
      @happiness_survey = HappinessSurvey.new(survey_params)
      if @happiness_survey.save(survey_params)
        flash[:success] = "New Happiness Survey Completed!"
        redirect_to root_path
      else
        render 'new'
      end
    else
      flash[:failure] = "Looks like you already filled out the Happiness Survey for this month. Here is what you previously answered, feel free to edit and resubmit it!"
      redirect_to edit_happiness_survey_path(id: happiness_survey_id)
    end
  end

  def edit
    @user = current_user
    @happiness_survey = HappinessSurvey.find(params[:id])
  end

  def update
    @happiness_survey = HappinessSurvey.find(params[:id])
    if @happiness_survey.update_attributes(survey_params)
      flash[:success] = "New Happiness Survey Completed!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def survey_params
    params[:happiness_survey][:round] = HappinessSurvey.digest_current_round_submission
    params.require(:happiness_survey).permit(:user_id, :meaning, :enthusiasm, :pride, :energy, :recognition, :support, :stamina, :growth, :development, :comments, :round)
  end

end