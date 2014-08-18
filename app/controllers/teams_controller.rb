class TeamsController < ApplicationController

  def team_charts
    @user = User.find(params[:id])
  end
end
