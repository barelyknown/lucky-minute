class MinutelyDrawingWorker
  include Sidekiq::Worker

  def perform
    Drawing.where("created_at < ?", Time.now - 24.hours).delete_all

    possible_numbers = (1..42).to_a

    drawn_numbers = 6.times.map do
      possible_numbers.delete(possible_numbers.sample)
    end

    Drawing.create!(numbers: drawn_numbers)

    time_zone = ActiveSupport::TimeZone.new("America/New_York")
    now_in_time_zone = time_zone.now
    if (8..20).cover?(now_in_time_zone.hour)
      next_drawing_at = Time.now + 1.minute
    else
      next_drawing_date = now_in_time_zone.to_date + 1
      next_drawing_at = time_zone.local(next_drawing_date.year, next_drawing_date.month, next_drawing_date.date, 8, 0).utc
    end

    MinutelyDrawingWorker.perform_at(next_drawing_at)
  end
end
