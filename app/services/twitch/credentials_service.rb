module Twitch
  class CredentialsService
    include HTTParty
    base_uri 'https://id.twitch.tv/oauth2'

    attr_reader :client_id

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def token
      response = self.class.post('/token', body: {
        client_id: @client_id,
        client_secret: @client_secret,
        grant_type: 'client_credentials'
      })

      if response.success?
        Rails.logger.info('Successfully obtained Twitch API token')
        response.parsed_response['access_token']
      else
        Rails.logger.error("Failed to obtain Twitch API token: #{response.code} - #{response.message}")
        raise "Failed to obtain Twitch API token: #{response.code} - #{response.message}"
      end
    rescue HTTParty::Error => e
      Rails.logger.error("Error obtaining Twitch API token: #{e.message}")
      raise # Re-raise the error to be handled by the calling code
    end
  end
end
