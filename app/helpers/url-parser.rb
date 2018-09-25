require 'down'
require 'nokogiri'
require 'htmlentities'

module Sinatra
  module WikiConverter
    module Helpers
      module URLParser
        def parse_url(url)
          html = Down.download(url)
          Nokogiri::HTML.parse(html)
        end

        def get_body(url)
          html = parse_url(url).css('body').to_s
          HTMLEntities.new.encode(html)
        end
      end
    end
  end
end