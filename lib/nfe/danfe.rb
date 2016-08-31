require 'net/http/post/multipart'
require 'tmpdir'

module Nfe
  class Danfe
    attr_accessor :open_timeout, :read_timeout

    def initialize(xml_or_file)
      if File.exist?(xml_or_file)
        @xml_or_file = xml_or_file
      else
        @xml_or_file = "#{Dir.tmpdir}/nota.xml"
        File.open(@xml_or_file, 'w') do |file|
          file.write(xml_or_file)
        end
      end
    end

    def pdf
      return @pdf if @pdf

      url = URI('http://freenfe.com.br/danfe/?view=1')

      http = Net::HTTP.new(url.host, url.port)
      http.open_timeout = self.open_timeout
      http.read_timeout = self.read_timeout
      req = Net::HTTP::Post::Multipart.new url.request_uri, nota: UploadIO.new(@xml_or_file, 'text/xml', 'nota.xml')

      request = http.request(req)
      @pdf = request.body
    end

  end
end
