module Tasks
  module Import
    class ResultCollection
      def initialize
        @results = {}
      end

      def find_or_build(swimmer, event, year, time)
        key = gen_key(swimmer, event, year)
        return @results[key] if @results.key?(key)
        result = Result.find_or_initialize_by(swimmer: swimmer, event: event, year: year)
        result.time = time
        @results[key] = result
        @results[key]
      end

      def import!
        @results.values.map(&:save!)
      end

      private

      def gen_key(swimmer, event, year)
        "#{swimmer.name}_#{swimmer.team.name}_#{event.name}_#{year}"
      end
    end
  end
end
