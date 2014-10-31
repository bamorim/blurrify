require 'RMagick'
require 'mail'

Mail.defaults do
  delivery_method :smtp,
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'poli.ufrj.br',
    :user_name            => ENV['EMAIL'],
    :password             => ENV['EMAIL_PASSWORD'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
end

class Blurrifier
  attr_reader :status, :image

  def initialize path, email, blur_factor
    @status = :pending
    @path = path
    @email = email
    @blur_factor = blur_factor
  end

  def process
    process_image
    puts "Processed #{@path} with blur factor of #{@blur_factor}"
    process_email
    puts "Sent email to #{@email}"
    @status = :success
  end

private
  def process_email
    image = @image
    factor = @blur_factor
    email = @email
    Mail.deliver do
      from 'bamorim@poli.ufrj.br'
      to email
      subject "Your image with blur factor of #{factor} was processed."
      body "Image processed with blur factor of #{factor}"
      add_file filename: "image.#{image.format.downcase}", content: image.to_blob
    end
  end

  def process_image
    bin = File.open(@path,"r"){|f| f.read}
    @image = Magick::ImageList.new.from_blob(bin).gaussian_blur(0.0,@blur_factor.to_f)
  end
end
