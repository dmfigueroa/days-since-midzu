module Twitch
  class ApiClient
    include HTTParty
    base_uri 'https://api.twitch.tv/helix'

    def initialize(credentials_service)
      @credentials_service = credentials_service
    end

    def streams(channels)
      response = self.class.get(
        '/streams',
        query: { user_login: channels },
        headers: { 'Client-ID': @credentials_service.client_id, 'Authorization': "Bearer #{@credentials_service.token}" }
      )

      response.parsed_response["data"]
    rescue HTTParty::Error => e
      Rails.logger.error("Twitch API request failed: #{e.message}")
      []
    rescue JSON::ParserError
      Rails.logger.error('Error parsing Twitch API response')
      []
    end
  end
end
