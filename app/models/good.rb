class Good < ApplicationRecord
  belongs_to :user
  belongs_to :live_record, optional: true
  belongs_to :artist, optional: true
  belongs_to :member, optional: true
  belongs_to :category
  accepts_nested_attributes_for :category
  validates :quantity, presence: true
  validates :name, length: { maximum: 15, message: "は15文字以内で入力してください。" }
end
