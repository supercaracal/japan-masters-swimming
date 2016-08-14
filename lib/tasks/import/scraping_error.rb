module Tasks
  module Import
    class ScrapingError < StandardError
      def initialize(error_message = nil)
        super("Failed to extract #{error_message}")
      end
    end
  end
end
