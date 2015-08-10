namespace :seed do
  task :minutely_drawings => :environment do
    MinutelyDrawingWorker.new.perform
  end
end
