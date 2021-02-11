module PupilfirstXapi
  class Outbox
    class << self
      def <<(payload)
        puts payload
      end
    end
  end
end
