module Tasks
  module Import
    class TeamCollection
      def initialize
        @teams = {}
      end

      def find_or_build(name)
        return @teams[name] if @teams.key?(name)
        @teams[name] = Team.find_or_initialize_by(name: name)
        @teams[name]
      end

      def import!
        @teams.values.map(&:save!)
      end
    end
  end
end
