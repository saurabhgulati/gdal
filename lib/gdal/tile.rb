module Gdal
  class Tile
    attr_accessor :file_path, :output_folder, :min_zoom, :max_zoom

    def initialize options={}
      self.file_path = options[:file_path]
      self.output_folder = options[:output_folder]
      self.min_zoom = options[:min_zoom]
      self.max_zoom = options[:max_zoom]
    end

    def generate
      execute([
        current_tool,
        "--z",
        "#{self.min_zoom}-#{self.max_zoom}",
        self.file_path, self.output_folder
      ])
    end

    def execute command, options={}
      Open3.popen3(*command) do |in_w, out_r, err_r, thread|
        [in_w, out_r, err_r].each(&:binmode)
        stdout_reader = Thread.new { out_r.read }
        stderr_reader = Thread.new { err_r.read }
        begin
          in_w.write options[:stdin].to_s
        rescue Errno::EPIPE
        end
        in_w.close

        begin
          Timeout.timeout(MiniMagick.timeout) { thread.join }
        rescue Timeout::Error
          Process.kill("TERM", thread.pid) rescue nil
          Process.waitpid(thread.pid)      rescue nil
          raise Timeout::Error, "MiniMagick command timed out: #{command}"
        end

        [stdout_reader.value, stderr_reader.value, thread.value]
      end
    end

    private

    def current_tool
      return 'gdal2tiles.py'
    end
  end
end
