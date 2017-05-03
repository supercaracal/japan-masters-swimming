class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    @ranks = Event.fetch_ranks
  end
end
