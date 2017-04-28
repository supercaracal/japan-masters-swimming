class TeamsController < ApplicationController
  def index
    @teams = Team.order(:name)
  end
end
