# frozen_string_literal: true

class Base < Grape::API
  format :json
  prefix :api

  mount V1::Rides

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    header['Access-Control-Request-Headers'] =
      'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    header['Access-Control-Request-Method'] = '*'
  end

  add_swagger_documentation(
    base_path: '/',
    api_version: 'v1',
    format: :json,
    hide_documentation_path: true,
    info: {
      title: 'USS EQT APIs',
      description: 'Main docs for the backend APIs'
    }
  )
end
