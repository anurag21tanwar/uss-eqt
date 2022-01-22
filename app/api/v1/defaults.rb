# frozen_string_literal: true

module V1
  module Defaults
    extend ActiveSupport::Concern

    included do
      version :v1, using: :path
      format :json
      prefix :api

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response({
          status: 'bad_request',
          error_message: e.message
        }.to_json, 400)
      end

      rescue_from :all do |e|
        rack_response({
          status: 'internal_server_error',
          error_message: e.message
        }.to_json, 500)
      end
    end
  end
end
