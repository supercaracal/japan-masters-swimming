module Tasks
  module Import
    class EventCollection
      def initialize
        @events = {}
      end

      def find_or_build(name)
        return @events[name] if @events.key?(name)
        @events[name] = Event.find_or_initialize_by(name: name)
        @events[name]
      end

      def import!
        @events.values.map(&:save!)
      end
    end
  end
end
