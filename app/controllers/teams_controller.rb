class TeamsController < ApplicationController
  before_action :signed_in_user

  def team_charts
    @user = User.find(params[:id])
  end
end
