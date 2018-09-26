require 'down'
require 'nokogiri'
require 'htmlentities'
require 'uri'

module Sinatra
  module HTMLConverter
    module Helpers
      module URLParser
        @attrs_to_not_strip = %w[src href colspan rowspan cols rows lang]

        def parse_url(url)
          if url !~ /\A#{URI::DEFAULT_PARSER.make_regexp}\z/
            raise URI::InvalidURIError
          end

          file = Down.download(url)
          doc = Nokogiri::HTML.parse(file, nil, 'utf-8')
          strip_attributes(doc)
        end

        def get_body(url)
          html = parse_url(url).css('body').to_s
          html = html.force_encoding('UTF-8').encode(invalid: :replace)
          HTMLEntities.new.encode(html)
        end

        def self.attrs_to_not_strip
          @attrs_to_not_strip
        end

        private

        def strip_attributes(doc)
          @attrs_to_not_strip = %w[src href colspan rowspan cols rows lang]

          attrs = @attrs_to_not_strip.map do |attr|
            "local-name() != '#{attr}'"
          end

          attrs = attrs.join(' and ')
          doc.xpath("//script|//style|//comment()|//@*[#{attrs}]").remove

          doc
        end
      end
    end
  end
end