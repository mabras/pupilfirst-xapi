module PupilfirstXapi
  module Statements
    class CertificateIssued
      def initialize(repository, uri_for)
        @repository = repository
        @uri_for = uri_for
      end

      def call(actor_id:, resource_id:)
        actor = @repository.call(:user, actor_id)
        issued_certificate = @repository.call(:issued_certificate, resource_id)

        context_activities = Xapi.create_context_activities(
          parent: [Xapi::Activity.new.tap { |obj| obj.id = PupilfirstXapi.uri_for.call(issued_certificate.course) }]
        )
        context = Xapi.create_context(
          extensions: {
            "http://id.tincanapi.com/extension/jws-certificate-location" => PupilfirstXapi.uri_for.call(issued_certificate),
          },
          context_activities: context_activities
        )

        Xapi.create_statement(
          actor: Actors.agent(actor),
          verb: Verbs::EARNED,
          object: Objects.issued_certificate(issued_certificate, @uri_for),
          context: context
        )
      end
    end
  end
end

