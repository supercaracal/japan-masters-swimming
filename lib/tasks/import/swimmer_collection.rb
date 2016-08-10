module Tasks
  module Import
    class SwimmerCollection
      def initialize
        @swimmers = {}
      end

      def find_or_build(team, name)
        key = gen_key(team, name)
        return @swimmers[key] if @swimmers.key?(key)
        @swimmers[key] = Swimmer.find_or_initialize_by(team: team, name: name)
        @swimmers[key]
      end

      def import!
        @swimmers.values.map(&:save!)
      end

      private

      def gen_key(team, name)
        "#{name}_#{team.name}"
      end
    end
  end
end
