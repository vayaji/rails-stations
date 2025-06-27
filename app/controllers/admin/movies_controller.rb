# frozen_string_literal: true

class Admin::MoviesController < ApplicationController
  before_action :set_movie, only: %i[show update destroy]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to admin_movies_path
    else
      flash.now[:alert] = @movie.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def update
    if @movie.update(movie_params)
      redirect_to admin_movies_path
    else
      flash.now[:alert] = @movie.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    flash[:notice] = 'Movie was successfully deleted.'
    redirect_to admin_movies_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   redirect_to admin_movies_path, alert: 'Movie not found.'
  end

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end

