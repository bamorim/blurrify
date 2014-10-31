require 'sidekiq'
require './blurrifier.rb'

class BlurrifierWorker
  include Sidekiq::Worker

  def perform path, email, blur_factor
    blurrifier = Blurrifier.new(path,email,blur_factor)
    blurrifier.process
    if blurrifier.status != :success
      raise StandardError.new("Deu erro manolo")
    end
  end
end
