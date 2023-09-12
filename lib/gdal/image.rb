module Gdal
  class Image
    attr_accessor :path, :output_format

    def initialize options={}
      @path = options[:path]
      @new_filename = options[:new_filename]
      @output_format = options[:output_format]
    end

    def info
      return Gdal::Info.get_coordinates(self.path)
    end

    def convert_to_png
      Gdal::Translate.new(path: self.path).convert_to_png
    end

    def get_image_from_coordinates x0, y0, xsize, ysize, file_name=nil
      Gdal::Translate.new(path: self.path, output_format: self.output_format).srcwin(
        x0, y0, xsize, ysize, file_name
      )
    end

    def find_geo_coordinates x0, y0, xsize, ysize, file_name: nil, file_path: nil
      image = get_image_from_coordinates x0, y0, xsize, ysize, file_name: file_name, file_path: file_path
      return Gdal::Info.get_coordinates(image.converted_path)
    end
  end
end
