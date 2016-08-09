module Nfe
  class Xml
    attr_accessor :result

    def initialize(xml_or_file)
      xml_or_file = File.read(xml_or_file) if File.exist?(xml_or_file)
      @xml_content = xml_or_file
    end

    def valid?
      case request
        when Net::HTTPSuccess then
          self.result = WebService::SearchResult.new(request.body)
          !request.body.include?('../Imagens/erro.png')
        else
          false
      end
    end

    private
    attr_accessor :xml_content

    def base_uri
      return @base_uri if @base_uri
      @base_uri = URI('https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx')
    end

    def request
      return @request if @request

      http = Net::HTTP.new(base_uri.host, base_uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(base_uri.request_uri)
      request.set_form_data(txtxml: xml_content)
      @request = http.request(request)
    end
  end
end
