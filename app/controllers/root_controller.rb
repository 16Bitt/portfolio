class RootController < ApplicationController
  get '/' do
    haml :index
  end
end
