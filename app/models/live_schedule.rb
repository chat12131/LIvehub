class LiveSchedule < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :venue
  belongs_to :user
  accepts_nested_attributes_for :venue
  mount_uploader :timetable, AvatarUploader
  mount_uploader :announcement_image, AvatarUploader
  before_save :clear_ticket_sale_date_if_not_unpurchased
  validates :date, presence: true
  validate :ticket_sale_date_validation
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0, message: "はマイナスの値を設定できません。", allow_blank: true }
  validates :drink_price, numericality: { greater_than_or_equal_to: 0, message: "はマイナスの値を設定できません。", allow_blank: true }
  validates :memo, length: { maximum: 300, message: "は300文字以内で入力してください。" }
  validate :date_cannot_be_in_the_past

  enum ticket_status: {
    未購入: 0,
    購入済: 1,
    当日のみ: 2,
    チケットレス: 3
  }

  def ticket_sale_date_validation
    return if ticket_sale_date.blank?

    errors.add(:ticket_sale_date, "は作成日以降である必要があります。") if ticket_sale_date < Time.zone.today
    errors.add(:ticket_sale_date, "はライブの日付より後である必要があります。") if ticket_sale_date.to_date > date
  end

  def date_cannot_be_in_the_past
    return unless date.present? && date < Time.zone.today

    errors.add(:date, "は過去の日付を設定することはできません。")
  end

  def days_until_live
    return nil unless date

    (date - Time.zone.today).to_i
  end

  def clear_ticket_sale_date_if_not_unpurchased
    return unless ticket_status != "未購入"

    self.ticket_sale_date = nil
  end
end
