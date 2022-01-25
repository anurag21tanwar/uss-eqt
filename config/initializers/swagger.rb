# frozen_string_literal: true

GrapeSwaggerRails.options.url = '/api/swagger_doc'
GrapeSwaggerRails.options.app_name = 'USS EQT APIs'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
