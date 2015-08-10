namespace :heroku do
  task :scale_worker_up => :environment do
    heroku = PlatformAPI.connect_oauth(ENV["HEROKU_API_TOKEN"])

    heroku.formation.update("lucky-minute", 'worker', { "quantity" => 1.to_s })
  end

  task :scale_worker_down => :environment do
    heroku = PlatformAPI.connect_oauth(ENV["HEROKU_API_TOKEN"])

    heroku.formation.update("lucky-minute", 'worker', { "quantity" => 0.to_s })
  end
end
