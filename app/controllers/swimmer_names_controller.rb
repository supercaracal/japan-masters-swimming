class SwimmerNamesController < ApplicationController
  def index
    @swimmers = if swimmer_name_params[:name].present?
                  Swimmer.where('name LIKE :name', name: "#{quoted_swimmer_name}%").includes(:team)
                else
                  Swimmer.none
                end
    render layout: false
  end

  private

  def swimmer_name_params
    params.require(:swimmer).permit(:name)
  end

  def quoted_swimmer_name
    Swimmer.connection.quote_string(swimmer_name_params[:name])
  end
end
