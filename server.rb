require 'sinatra'
require 'sinatra/reloader' if development?

require './image_presenter.rb'
require './blurrifier.rb'
require './blurrifier_worker.rb'

get '/' do
  erb :index
end

post '/blurrify' do
  start_time = Time.now

  filename = "/home/bamorim/tmp/#{rand(100)}.png"
  File.open(filename, "w") do |f|
    File.open(params["image"][:tempfile],"r") do |tmp|
      f.write tmp.read
    end
  end

  @blurrifiers = (1..3).each do |i|
    BlurrifierWorker.perform_async(filename, params["email"], i)
  end

  end_time = Time.now
  puts "Done"
  @elapsed = (end_time - start_time)*1000
  "Done in #{@elapsed}ms"
end
