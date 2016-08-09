require 'net/http'
require 'nokogiri'

module Nfe
  module WebService
    class SearchResult
      attr_accessor :body

      def initialize(html_body)
        self.body = html_body
      end

      def messages
        return @msg if @msg
        nodes = Nokogiri::HTML(body).css('.tabela_resultado li').to_a
        @msg   = {}

        nodes[0..2].each do |node|
          @msg[gsub_key(node)] = gsub_message(node)
        end

        nodes[3].css('ul li').each do |node|
          @msg[gsub_key(node)] = gsub_message(node)
        end if nodes[3]

        @msg
      end

      private
      def gsub_message(node)
        node.to_s.
            gsub(node.css('img').to_s,'').
            gsub(node.css('b').to_s, '').
            gsub(node.css('a').to_s, '').
            gsub(/\[\]/, '').
            gsub(/^CN=/, '').
            gsub(/<\/?li>/, '').
            gsub(/\t|\n/, '').
            strip
      end

      def gsub_key(node)
        node.css('b').to_s.
            gsub(/<\/?b>/, '').
            gsub(/\t|\n/, '').
            strip
      end
    end
  end
end
