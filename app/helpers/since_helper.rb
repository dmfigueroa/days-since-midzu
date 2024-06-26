module SinceHelper
  def days_since(date)
    (Time.now - date).to_i / 86400
  end
end
