class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    if !params[:schedule_id].present?
      redirect_to movies_path, alert: "上映スケジュールのIDが必要です" and return
    end
    if !params[:sheet_id].present?
      redirect_to movies_path, alert: "座席のIDが必要です" and return
    end
    if !params[:screen_id].present?
      redirect_to movies_path, alert: "スクリーンのIDが必要です" and return
    end
    if !params[:date].present?
      redirect_to movies_path, alert: "日付が必要です" and return
    end
    @reservation = Reservation.new
    @reservation.schedule_id = params[:schedule_id]
    @reservation.sheet_id = params[:sheet_id]
    @reservation.screen_id = params[:screen_id]
    @reservation.date = params[:date] || Date.today.strftime("%F")
  end

  def create
    @reservation = Reservation.new(reservation_params)
  
    begin
      @reservation.save!
      redirect_to movie_path(@reservation.schedule.movie), notice: "予約が完了しました。"
    rescue ActiveRecord::RecordNotUnique
      redirect_to movie_reservation_path(
        movie_id: @reservation.schedule.movie.id,
        schedule_id: @reservation.schedule_id,
        date: @reservation.date.strftime('%Y-%m-%d')
      ), alert: "その座席はすでに予約済みです。"
    rescue ActiveRecord::RecordInvalid
      redirect_to movie_reservation_path(
        movie_id: @reservation.schedule.movie.id,
        schedule_id: @reservation.schedule_id,
        date: @reservation.date
      ), alert: "予約に失敗しました。"
    end
  end
  private
  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :screen_id, :user)
  end
end
