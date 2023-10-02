class LiveSchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_live_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @live_schedules = current_user.live_schedules.where("date >= ?", Date.yesterday).order(:date)
  end

  def show
    @live_schedules = LiveSchedule.find(params[:id])
  end

  def new
    @live_schedule = LiveSchedule.new
    @live_schedule.build_venue
  end

  def edit; end

  def create
    @live_schedule = current_user.live_schedules.build(live_schedule_params)

    venue_data = live_schedule_params[:venue_attributes]

    existing_venue = if venue_data[:google_place_id].present?
                       Venue.find_by(name: venue_data[:name], google_place_id: venue_data[:google_place_id], user_id: current_user.id)
                     else
                       Venue.find_by(name: venue_data[:name], user_id: current_user.id)
                     end

    if existing_venue
      @live_schedule.venue = existing_venue
    else
      venue = @live_schedule.build_venue(venue_data)
      venue.user = current_user
    end

    if @live_schedule.date.nil?
      render :new
      return
    end

    if @live_schedule.name.blank?
      date_str = @live_schedule.date.strftime("%-m月%-d日")
      @live_schedule.name = "#{date_str} #{@live_schedule.venue.area}"
    end

    if @live_schedule.save
      redirect_to live_schedules_path
    else
      Rails.logger.debug @live_schedule.errors.full_messages
      render :new
    end
  end

  def update
    @live_schedule = LiveSchedule.find(params[:id])

    venue_data = live_schedule_params[:venue_attributes]

    existing_venue = if venue_data[:google_place_id].present?
                       Venue.find_by(name: venue_data[:name], google_place_id: venue_data[:google_place_id], user_id: current_user.id)
                     else
                       Venue.find_by(name: venue_data[:name], user_id: current_user.id)
                     end

    if @live_schedule.name.blank?
      date_str = @live_schedule.date.strftime("%-m月%-d日")
      @live_schedule.name = "#{date_str} #{@live_schedule.venue.area}"
    end

    @live_schedule.assign_attributes(live_schedule_params)

    if existing_venue
      @live_schedule.venue = existing_venue
    else
      venue = @live_schedule.build_venue(venue_data.except(:user, :user_id))
      venue.user = current_user
      unless venue.save
        @live_schedule.errors.add(:venue, "の保存に失敗しました。")
        Rails.logger.debug venue.errors.full_messages
        render :edit and return
      end
    end

    if @live_schedule.save
      redirect_to live_schedules_path
    else
      Rails.logger.debug @live_schedule.errors.full_messages
      render :edit
    end
  end

  def destroy
    @live_schedule.destroy
    redirect_to live_schedules_path
  end

  private

  def set_live_schedule
    @live_schedule = current_user.live_schedules.find(params[:id])
  end

  def live_schedule_params
    params.require(:live_schedule).permit(:name, :date, :artist_id, :open_time, :start_time, :ticket_status, :ticket_sale_date, :ticket_price, :drink_price, :timetable, :announcement_image, :memo,
                                          venue_attributes: [:name, :google_place_id, :area, :latitude, :longitude])
  end
end
