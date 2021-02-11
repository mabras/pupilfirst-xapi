module PupilfirstXapi
  module Statements
    class TargetCompleted
      def call(actor_id:, resource_id:, **_)
        Xapi.create_statement(
          actor: PupilfirstXapi::Actor.new.call(actor_id),
          verb: Verbs::COMPLETED_ASSIGNMENT,
          object: object(resource_id).call
        )
      end

      private

      def object(resource_id)
        target = PupilfirstXapi.target_class.find(resource_id)
        PupilfirstXapi::Object.new(
          id: PupilfirstXapi.uri_for(target),
          type: "http://activitystrea.ms/schema/1.0/task",
          name: target.title,
          description: target.description
        )
      end
    end
  end
end
