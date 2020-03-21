# frozen_string_literal: true

require "#{__dir__}/boot.rb"

map('/') { run RootController }
map('/text_alerts') { run TextAlertsController }
