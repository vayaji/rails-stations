class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show ]
  def index
    keyword = params[:keyword]
    is_showing = params[:is_showing]
    @movies = Movie.all
    if is_showing == "1"
      @movies = @movies.where(is_showing: true)
    elsif is_showing == "0"
      @movies = @movies.where(is_showing: false)
    end

    if keyword.present?
      @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end
  end
  def show
    
  end

private
  def set_movie
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end
end
