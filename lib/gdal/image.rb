module Gdal
  class Image
    attr_accessor :path

    def initialize options={}
      @path = options[:path]
      @new_filename = options[:new_filename]
    end

    def info
      return Gdal::Info.get_coordinates(self.path)
    end

    def convert_to_png
      Gdal::Translate.new(path: self.path).convert_to_png
    end

    def get_image_from_coordinates x0, y0, xsize, ysize, file_name=nil
      Gdal::Translate.new(path: self.path).srcwin(
        x0, y0, xsize, ysize, file_name
      )
    end

    def find_geo_coordinates x0, y0, xsize, ysize, file_name: nil, file_path: nil
      image = get_image_from_coordinates x0, y0, xsize, ysize, file_name=nil
      return Gdal::Info.get_coordinates(image.converted_path)
    end
  end
end
