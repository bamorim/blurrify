require 'base64'

class ImagePresenter
  def initialize image
    @image = image
  end

  def to_html
    "<img src=\"data:image/#{@image.format.downcase};base64,#{self.to_base64}\"/>"
  end

  def to_base64
    Base64.encode64(@image.to_blob)
  end
end

