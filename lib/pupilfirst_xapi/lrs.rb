require 'xapi'

module PupilfirstXapi
  class Lrs
    def initialize(
      end_point: ENV['LRS_ENDPOINT'],
      key: ENV['LRS_KEY'],
      secret: ENV['LRS_SECRET']
    )
      @lrs = end_point && key && secret &&
        Xapi.create_remote_lrs(
          end_point: end_point,
          user_name: key,
          password: secret
        )
    end

    def call(statement)
      return unless statement && @lrs

      Xapi.post_statement(remote_lrs: @lrs, statement: statement)
    end
  end
end
