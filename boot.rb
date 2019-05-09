# frozen_string_literal: true

require 'sinatra'
require 'haml'

APP_ROOT = File.dirname(__FILE__)

Dir.glob('./src/*.rb').each { |file| require file }
