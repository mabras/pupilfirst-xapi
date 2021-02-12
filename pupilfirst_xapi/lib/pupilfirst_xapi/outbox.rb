require 'xapi'

module PupilfirstXapi
  class Outbox
    class << self
      def <<(payload)
        puts payload
      end
    end

    def initialize(lrs:)
      @lrs = lrs
    end

    def call(payload)
      Xapi.post_statement(remote_lrs: @lrs, statement: statement_for(**payload))
    end

    private
    attr_reader :lrs

    def statement_for(id:, event_type:, timestamp:, **args)
      Statements.builder_for(event_type).call(args).tap do |statement|
        statement.stamp(id: id, timestamp: timestamp)
      end
    end
  end
end
