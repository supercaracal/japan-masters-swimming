class ResultsController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @swimmer = Swimmer.find(params[:swimmer_id])
  end
end
