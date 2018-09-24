require 'down'
require 'nokogiri'

module Sinatra
  module WikiConverter
    module Helpers
      module URLParser
        def parse_url(url)
          html = Down.download(url)
          Nokogiri::HTML(html)
        end

        def get_body(url)
          parse_url(url).css('body')
        end
      end
    end
  end
end