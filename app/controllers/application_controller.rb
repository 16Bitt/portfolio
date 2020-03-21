class ApplicationController < Sinatra::Application
  set :views, settings.root + '/app/views'
end
