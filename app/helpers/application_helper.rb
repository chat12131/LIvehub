module ApplicationHelper
  def days_since(date)
    (Time.zone.today - date.to_date).to_i
  end
end
