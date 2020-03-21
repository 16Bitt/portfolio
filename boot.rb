# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

require 'dotenv'
require 'haml'

Dotenv.load
APP_ROOT = File.dirname(__FILE__)

%i[development test production].each do |env|
  configure env do
    set :database, url: ENV['DATABASE_URL']
  end
end

# Ensure that the base class loads first
require './app/controllers/application_controller.rb'

Dir.glob('./app/**/*.rb').each { |file| require file }

