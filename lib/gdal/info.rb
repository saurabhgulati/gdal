module Gdal
  class Info
    attr_reader :path, :upper_left, :upper_right, :lower_left, :lower_right, :center, :data

    def initialize options={}
      @path = options[:path]
      @upper_left = options[:upper_left]
      @upper_right = options[:upper_right]
      @lower_left = options[:lower_left]
      @lower_right = options[:lower_right]
      @center = options[:center]
      @data = options[:data]
    end

    def self.get_coordinates path
      if Gdal.check_tool("gdalinfo")
        if File.exist?(path)
          info = `gdalinfo -json #{path}`
          info = JSON.parse(info)
          coords = info["wgs84Extent"]["coordinates"][0]

          return Gdal::Info.new(
            path: path,
            upper_left: coords[0],
            lower_left: coords[1],
            lower_right: coords[2],
            upper_right: coords[3],
            center: coords[4],
            data: info
          )
        else
          raise "Error! File #{file} does not exist."
        end
      end
    end
  end
end
