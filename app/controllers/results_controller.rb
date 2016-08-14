class ResultsController < ApplicationController
  def index
    @swimmer = Swimmer.find(params[:swimmer_id])
  end
end
