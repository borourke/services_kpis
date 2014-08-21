require 'cf_api'

class SurveysController < ApplicationController
  def new
    @survey = Survey.new
    @user = User.find(params[:id])
  end

  def create
    job_id = CfApi.create_survey(survey_params)
    @survey = Survey.new(survey_params)
    if @survey.save
      flash.now[:success] = "Survey Successfully Created!"
      redirect_to :controller => 'surveys', :action => 'new_survey_page_two', :id => survey_params[:user_id], :job_id => job_id
    else
      render 'new'
    end
  end

  def new_survey_page_two
    @user = User.find(params[:id])
    @job_id = params[:job_id]
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

    def survey_params
      params.require(:survey).permit(:title, :respondants, :prescreen, :survey, :job_owner, :project_number, :payment_cents, :user_id)
    end

end
