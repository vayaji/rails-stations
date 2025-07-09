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
    @screens = Screen.all
  end

  def reservation
    if !params[:movie_id].present?
      redirect_to movies_path, alert: "映画のIDが必要です" and return
    end
    @movie = Movie.find(params[:movie_id])
    if !params[:schedule_id].present?
      redirect_to @movie, alert: "上映スケジュールのIDが必要です" and return
    end
    @schedule = Schedule.find_by(id: params[:schedule_id])
    if !params[:screen_id].present?
      redirect_to @movie, alert: "スクリーンのIDが必要です" and return
    end
    @screen = Screen.find_by(id: params[:screen_id])
    if !params[:date].present?
      redirect_to @movie, alert: "日付が必要です" and return
    end
    @date = params[:date] || Date.today.strftime("%F")

    @sheets = Sheet.all
    @rows = @sheets.map(&:row).uniq.sort
    @columns = @sheets.map(&:column).uniq.sort

    @reservations = Reservation.where(date: params[:date], schedule_id: @schedule.id, screen_id: @screen.id)
    @reserved_sheet_ids = @reservations.pluck(:sheet_id)
  end

private
  def set_movie
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end


end
