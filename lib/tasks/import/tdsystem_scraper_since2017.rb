require 'nkf'

module Tasks
  module Import
    class TdsystemScraperSince2017
      def scrape(html)
        doc = Nokogiri::HTML(encode(html))
        event_name = extract_event_name(doc)
        results = extract_results(doc)
        return if event_name.blank? || results.blank? || event_name.index('リレー')
        OpenStruct.new(event_name: event_name, results: results)
      end

      private

      def encode(html, from_enc: Encoding::UTF_8, to_enc: Encoding::UTF_8)
        from_enc = NKF.guess(html)
        html.encode(to_enc, from_enc, invalid: :replace, undef: :replace, replace: '')
      end

      def normalize(text)
        text = text.gsub(/[　\s ]+|&nbsp;/, '')
        NKF.nkf('-m0Z1 -W -w', text)
      end

      def extract_event_name(doc)
        text = doc.css('h3').text
        normalize(text).scan(TdsystemScraper::REGEXP_EVENT_NAME).map(&:join).first
      end

      def extract_results(doc)
        doc.xpath('//table/tr').map do |row|
          cells = row.xpath('td').map(&:text).map { |text| normalize(text) }
          time = convert_to_float(cells[7])
          next if time.blank?
          OpenStruct.new(swimmer: cells[2], team: cells[3], time: time)
        end.compact
      end

      def convert_to_float(text)
        match_data = text&.match(TdsystemScraper::REGEXP_TIME)
        return if match_data.blank?

        second = match_data[1]&.tr(':', '').to_i * 60 + match_data[2].to_i
        millisecond = match_data[3]
        "#{second}.#{millisecond}".to_f
      end
    end
  end
end
