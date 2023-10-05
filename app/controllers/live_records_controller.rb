class LiveRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_live_record, only: [:show, :edit, :update, :destroy]

  def index
    @live_records = current_user.live_records.where("date <= ?", Time.zone.today).order(date: :desc)
  end

  def show
  end

  def new
    @live_record = LiveRecord.new
    @live_record.build_venue
  end

  def edit
 end

  def create
    @live_record = current_user.live_records.build(live_record_params)

    venue_data = live_record_params[:venue_attributes]

    existing_venue = if venue_data[:google_place_id].present?
                       Venue.find_by(name: venue_data[:name], google_place_id: venue_data[:google_place_id], user_id: current_user.id)
                     else
                       Venue.find_by(name: venue_data[:name], user_id: current_user.id)
                     end

    if existing_venue
      @live_record.venue = existing_venue
    else
      venue = @live_record.build_venue(venue_data)
      venue.user = current_user
    end

    if @live_record.date.nil?
      render :new
      return
    end

    if @live_record.name.blank?
      date_str = @live_record.date.strftime("%-m月%-d日")
      @live_record.name = "#{date_str} #{@live_record.venue.area}"
    end

    if @live_record.save
      redirect_to live_records_path
    else
      Rails.logger.debug @live_record.errors.full_messages
      render :new
    end
  end

  def update
    venue_data = live_record_params[:venue_attributes]

    existing_venue = if venue_data[:google_place_id].present?
                       Venue.find_by(name: venue_data[:name], google_place_id: venue_data[:google_place_id], user_id: current_user.id)
                     else
                       Venue.find_by(name: venue_data[:name], user_id: current_user.id)
                     end

    if @live_record.name.blank?
      date_str = @live_record.date.strftime("%-m月%-d日")
      @live_record.name = "#{date_str} #{@live_record.venue.area}"
    end

    @live_record.assign_attributes(live_record_params)

    if existing_venue
      @live_record.venue = existing_venue
    else
      venue = @live_record.build_venue(venue_data.except(:user, :user_id))
      venue.user = current_user
      unless venue.save
        @live_record.errors.add(:venue, "の保存に失敗しました。")
        Rails.logger.debug venue.errors.full_messages
        render :edit and return
      end
    end

    if @live_record.save
      redirect_to live_records_path
    else
      render :edit
    end
  end

  def destroy
    @live_record.destroy
    redirect_to live_records_path
  end

  def details
    live_record = LiveRecord.find(params[:id])
    render json: { date: live_record.date, artist: live_record.artist }
  end

  private

  def set_live_record
    @live_record = current_user.live_records.find(params[:id])
  end

  def live_record_params
    params.require(:live_record).permit(:name, :date, :artist_id, :start_time, :ticket_price, :drink_price, :timetable, :announcement_image, :memo,
                                        venue_attributes: [:name, :google_place_id, :area, :latitude, :longitude])
  end
end
