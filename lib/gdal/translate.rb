module Gdal
  class Translate
    OUTPUT_FORMATS = ["GTiff", "PNG"]

    FILE_EXT_PER_DRIVER = {
      "gtiff" => "tif",
      "png" => "png"
    }
    attr_accessor :path, :converted_path, :converted_filename, :output_format

    def initialize options={}
      if Gdal.check_tool("gdal_translate")
        @path = options[:path]
        @converted_path = options[:converted_path]
        @converted_filename = options[:converted_filename]
        @output_format = options[:output_format] || "GTiff"
      end
    end

    def convert_to_png
      # if Gdal.check_tool("gdal_translate")
      new_path = "#{get_file_path}/#{get_file_name}.png"
      resp = `gdal_translate -of PNG -ot Byte #{self.path}  #{new_path}`
      return Gdal::Translate.new(
        path: self.path,
        converted_path: new_path,
        converted_filename: get_file_name.to_s.strip+".png"
      )
      # end
    end

    def srcwin x0, y0, xsize, ysize, file_name: nil, file_path: nil
      new_path = "#{file_path || get_file_path}/#{file_name || get_file_name}.#{Gdal::Translate::FILE_EXT_PER_DRIVER[self.output_format.downcase]}"
      resp = `gdal_translate -srcwin #{x0} #{y0} #{xsize} #{ysize} -of #{self.output_format} #{self.path} #{new_path}`
      return Gdal::Translate.new(
        path: self.path,
        converted_path: new_path,
        converted_filename: get_file_name.to_s.strip+".png"
      )
    end

    private

    def get_file_name
      File.basename(self.path)
    end

    def get_file_path
      File.split(self.path)[0]
    end
  end
end
