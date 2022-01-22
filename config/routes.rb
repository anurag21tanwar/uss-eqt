# frozen_string_literal: true

Rails.application.routes.draw do
  mount Base => '/'
  mount GrapeSwaggerRails::Engine => '/'
end
