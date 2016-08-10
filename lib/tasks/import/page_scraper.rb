require 'nkf'

module Tasks
  module Import
    class PageScraper
      include ActionView::Helpers::SanitizeHelper

      class ScrapingError < StandardError; end

      REGEXP_EVENT_NAME = /\ANo.\ *[0-9]+\ *(女子|男子)\ *([0-9]+m)\ *(自由形|平泳ぎ|背泳ぎ|バタフライ|個人メドレー)\z/
      REGEXP_RESULT = /\A[0-9]*\ *([^(]+)\ *\((.+)\)\ *([0-9:.]+)\z/
      REGEXP_TIME = /\A([0-9]+:)?([0-9]+)\.([0-9]+)\z/

      attr_reader :event_name
      attr_reader :results

      def initialize(html)
        @results = []
        convert_to_rows(html).each do |row|
          extract_event_name(row) if @event_name.blank?
          extract_result(row)
        end
        raise ScrapingError, 'Failed to extract a event name.' if @event_name.blank?
        raise ScrapingError, 'Failed to extract results.' if @results.blank?
      end

      private

      def convert_to_rows(html)
        strip_tags(encode(html).gsub('&nbsp;', ' '))
          .split(/[\r\n]+/)
          .map { |row| row.gsub(/[　\s]+/, ' ') }
          .map(&:strip)
          .map(&:presence)
          .compact
      end

      def encode(text, from: Encoding::UTF_8, to: Encoding::UTF_8)
        from = NKF.guess(text)
        text.encode(to, from, invalid: :replace, undef: :replace, replace: '')
      end

      def extract_event_name(row)
        match_data = row.match(REGEXP_EVENT_NAME)
        return if match_data.blank?
        @event_name = normalize_text(match_data.to_a.from(1).join(''))
      end

      def extract_result(row)
        match_data = row.match(REGEXP_RESULT)
        return if match_data.blank?
        tuple = match_data.to_a.map { |data| normalize_text(data) }
        @results << OpenStruct.new(swimmer: tuple[1], team: tuple[2], time: convert_to_float(tuple[3]))
      end

      def normalize_text(text)
        NKF.nkf('-m0Z1 -W -w', text.tr(' ', ''))
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
