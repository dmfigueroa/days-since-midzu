module Twitch
  class StreamStatusService
    def initialize(api_client)
      @api_client = api_client
    end

    def any_streaming?(channels)
      streams_data = @api_client.streams(channels)

      !streams.empty?
    end
  end
end
