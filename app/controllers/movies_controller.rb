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

  def reservation
    if !params[:movie_id].present?
      redirect_to movies_path, alert: "映画のIDが必要です" and return
    end
    if !params[:schedule_id].present?
      redirect_to movies_path, alert: "上映スケジュールのIDが必要です" and return
    end
    if !params[:date].present?
      redirect_to movies_path, alert: "日付が必要です" and return
    end
    @schedule = Schedule.find_by(id: params[:schedule_id])
    @movie = Movie.find(params[:movie_id])
    @sheets = Sheet.all
    @rows = @sheets.map(&:row).uniq.sort
    @columns = @sheets.map(&:column).uniq.sort

    @reservations = Reservation.where(schedule_id: @schedule.id, date: params[:date])
    @date = params[:date] || Date.today.strftime("%F")
    @reserved_sheet_ids = @reservations.pluck(:sheet_id)
  end

private
  def set_movie
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end


end
