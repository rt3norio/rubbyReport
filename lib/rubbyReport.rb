require 'thor'
require 'base64'
require 'erb'

class RubbyReport
    def initialize
        @images_list = Dir.glob("*png")
        @images_list.reverse!
    end

    def generate_base_64_from_img_to_src(path)
        File.open(path, 'rb') do |img|
            'data:image/png;base64,' + Base64.strict_encode64(img.read)
        end
    end
    
    def run(description = "", key = "",template='basic')
        data = ReportData.new
        data.images_array =  @images_list.map do |img|
            [img.split('@')[-2], generate_base_64_from_img_to_src(img)]
        end
        data.issue_description = description
        data.issue_key = key
        data.time = Time.now        
        filename = key = '' ? "#{key}.html" : "report.html"

        view = Report.new(template, data)
        File.write(filename, view.render)
        puts "generated #{filename} file in current folder."
    end
end

class Report
    def initialize(page, data = {})
      @data = data
      @page = page
      file = File.join(File.dirname(__FILE__), "./templates/#{page}.html.erb")
      @template = File.read(file)
    end

    def render
      ERB.new(@template).result(binding)
    end
end

class ReportData
    attr_accessor :issue_key, :issue_description, :time, :images_array
end


# 3) pedir ao usuĂĄrio qual o nome do tĂ­tulo a ser inserido no HTML

# 4) inserir titulo e imagem em base 64 conforme template html





