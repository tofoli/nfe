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
      
      def errors
        return @errors if @errors
        nodes = Nokogiri::HTML(body).css('.tabela_resultado li').to_a
        @errors   = {}

        nodes[0..2].each do |node|
          next unless node.to_s.include?('../Imagens/erro.png')
          @errors[gsub_key(node)] = gsub_message(node)
        end

        nodes[3].css('ul li').each do |node|
          next unless node.to_s.include?('../Imagens/erro.png')
          @errors[gsub_key(node)] = gsub_message(node)
        end if nodes[3]

        @errors
      end

      private
      def gsub_message(node)
        normalize_node(node).last.force_encoding('utf-8')
      end

      def gsub_key(node)
        normalize_node(node).first.force_encoding('utf-8')
      end

      def normalize_node(node)
        node.to_s.
            gsub(node.css('img').to_s,'').
            gsub(node.css('a').to_s, '').
            gsub(/\[\]/, '').
            gsub(/^CN=/, '').
            gsub(/<\/?li>/, '').
            gsub(/<\/?b>/, '').
            gsub(/\t|\n/, '').
            strip.split(': ')
      end
    end
  end
end
