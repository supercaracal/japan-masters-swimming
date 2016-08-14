require 'nkf'

module Tasks
  module Import
    class TdsystemScraper
      include ActionView::Helpers::SanitizeHelper

      REGEXP_EVENT_NAME = /No.[0-9]+(女子|男子)([0-9]+m)(自由形|平泳ぎ|背泳ぎ|バタフライ|個人メドレー)/
      REGEXP_RESULT = /[0-9]*歳?([^()0-9]+)\(([^()]+)\)([0-9]*:?[0-9]{1,2}\.[0-9]{1,2})/
      REGEXP_TIME = /([0-9]+:)?([0-9]+)\.([0-9]+)/

      def scrape(html)
        text = convert_to_simple_text(html)
        event_name = extract_event_name(text)
        results = extract_results(text)
        raise ScrapingError, 'a event name.' if event_name.blank?
        raise ScrapingError, 'results.' if results.blank?
        OpenStruct.new(event_name: event_name, results: results)
      end

      private

      def convert_to_simple_text(html, from_enc: Encoding::UTF_8, to_enc: Encoding::UTF_8)
        from_enc = NKF.guess(html)
        encoded_html = html.encode(to_enc, from_enc, invalid: :replace, undef: :replace, replace: '')
        striped_html = encoded_html.gsub(/[　\s ]+|&nbsp;/, '')
        normalized_html = NKF.nkf('-m0Z1 -W -w', striped_html)
        # `strip_tags` method remove overrun string implicitly. So fuck'n method!
        normalized_html.split('>').map { |row| "#{row}>" }.map { |row| strip_tags(row) }.join('')
      end

      def extract_event_name(text)
        text.scan(REGEXP_EVENT_NAME).map(&:join).first
      end

      def extract_results(text)
        text.scan(REGEXP_RESULT).map do |match|
          match = match.map(&:strip)
          OpenStruct.new(swimmer: match[0], team: match[1], time: convert_to_float(match[2]))
        end
      end

      def convert_to_float(text)
        match_data = text.match(REGEXP_TIME)
        raise ScrapingError, "Unknown result time #{text}" if match_data.blank?
        second = match_data[1]&.tr(':', '').to_i * 60 + match_data[2].to_i
        millisecond = match_data[3]
        "#{second}.#{millisecond}".to_f
      end
    end
  end
end
