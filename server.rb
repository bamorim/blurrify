require 'sinatra'
require 'sinatra/reloader' if development?

require './image_presenter.rb'
require './blurrifier.rb'

get '/' do
  erb :index
end

post '/blurrify' do
  start_time = Time.now

  @blurrifiers = (1..5).map do |i|
    blurrifier = Blurrifier.new params["image"][:tempfile].path, params["email"], i
  end

  @blurrifiers.each { |b| b.process }

  end_time = Time.now
  @elapsed = (end_time - start_time)*1000
  if @blurrifiers.all?{|b| b.status == :success }
    @images = @blurrifiers.map{|b| ImagePresenter.new(b.image) }
    erb :success
  else
    erb :error
  end
end
