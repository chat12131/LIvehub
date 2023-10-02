module ApplicationHelper
  def days_since(date)
    (Date.today - date.to_date).to_i
  end
end
