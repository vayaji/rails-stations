class Admin::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    # @reservations = Reservation.where("date >= ?", Date.today)
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
    @movies = Movie.all
    @sheets = Sheet.all

    if params[:movie_id].present?
      @schedules = Schedule.where(movie_id: params[:movie_id])
      @movie_id = params[:movie_id]
    else
      @schedules = []
    end
  end
  def create
    @reservation = Reservation.new(reservation_params)
    begin
      if @reservation.save
        redirect_to admin_reservations_path, notice: 'Reservation was successfully created.'
      else
        @movies = Movie.all
        @sheets = Sheet.all
        if params[:movie_id].present?
          @schedules = Schedule.where(movie_id: params[:movie_id])
          @movie_id = params[:movie_id]
        else
          @schedules = []
        end
        flash.now[:alert] = @reservation.errors.full_messages.to_sentence
        render :new, status: :bad_request
      end
    rescue ActiveRecord::RecordNotUnique => e
      logger.error "DBユニーク制約違反（RecordNotUnique）: #{e.message} | Params: #{reservation_params.inspect}"
      flash.now[:alert] = 'この予約は既に存在します。別の日時を選択してください。'
      render :new, status: :bad_request
    end
  end

  def show
    @movies = Movie.all
    @sheets = Sheet.all

    if params[:movie_id].present?
      @schedules = Schedule.where(movie_id: params[:movie_id])
      @movie_id = params[:movie_id]
    else
      @schedules = []
    end
  end
  def update
    begin
      if @reservation.update(reservation_params)
        redirect_to admin_reservations_path, notice: 'Reservation was successfully updated.'
      else
        @movies = Movie.all
        @sheets = Sheet.all

        if params[:movie_id].present?
          @schedules = Schedule.where(movie_id: params[:movie_id])
          @movie_id = params[:movie_id]
        else
          @schedules = []
        end
        flash.now[:alert] = @reservation.errors.full_messages.to_sentence
        render :show, status: :bad_request
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = 'この予約は既に存在します。別の日時を選択してください。'
      render :show, status: :bad_request
    end
  end
  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: 'Reservation was successfully destroyed.'
  end


  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :user_id, :date, :email, :name)
  end
end