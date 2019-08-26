require "open3"
module Gdal
  class Tool
    attr_accessor :tool
    def initialize tool_name, options={}
      @tool = tool
    end

    def execute options={}
      Open3.popen3(@tool, options[:stdin])
    end
  end
end
