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
    
    def run
        data = ReportData.new
        data.images_array =  @images_list.map do |img|
            [img.split('@')[-2], generate_base_64_from_img_to_src(img)]
        end
        data.issue_description = 'descricao do que o ticket pedia'
        data.date = Time.now        
        data.issue_key = "TO-15492"


        view = Report.new('basic', data)
        File.write("report.html", view.render)
    
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
    attr_accessor :issue_key, :issue_description, :date, :images_array
end


# 3) pedir ao usuĂĄrio qual o nome do tĂ­tulo a ser inserido no HTML

# 4) inserir titulo e imagem em base 64 conforme template html




