class TwitchStreamCheckerJob < ApplicationJob
  queue_as :default

  def perform
    streams = %w[midzui jhulzui]
    credentials = Twitch::CredentialsService.new(ENV['TWITCH_CLIENT_ID'], ENV['TWITCH_CLIENT_SECRET'])
    client = Twitch::ApiClient.new(credentials)
    status_service = Twitch::StreamStatusService.new(client)

    if status_service.any_streaming?(streams)
      record = Record.first
      record.lasst_stream = Time.now
      record.save!
    end
  end
end
