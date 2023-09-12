require "gdal/railtie"

module Gdal
  # Your code goes here...
  VALID_TOOLS = %w(gdalinfo gdal_translate gdal2tiles.py)

  def self.check_tool tool
    if Gdal::VALID_TOOLS.include?(tool)
      res = `which #{tool}`
      raise "gdalinfo in not installed on this system! Please install it to use this library" if res.blank?
      return true
    else
      raise "This #{tool} is incompatible! you can only use: #{Gdal::VALID_TOOLS.join(", ")}"
    end
  end

  require "open3"
  require "gdal/image"
  require "gdal/info"
  require "gdal/translate"
  require "gdal/tile"
end
