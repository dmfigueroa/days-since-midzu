namespace :twitch_stream_checker do
  desc "Perform the Twitch stream check job"
  task perform: :environment do
    begin
      TwitchStreamCheckerJob.perform_now
    rescue StandardError => e
      Rails.logger.error "Twitch stream checker failed: #{e.message}"
    end
  end
end
