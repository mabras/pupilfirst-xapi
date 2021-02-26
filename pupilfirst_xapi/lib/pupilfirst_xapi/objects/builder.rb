module PupilfirstXapi
  module Objects
    class Builder
      def initialize(id:, name:, description:, type:)
        @params = {
          id: id,
          name: name,
          description: description,
          type: type
        }
      end

      def with_extension(type, value)
        @params[:extensions] ||= {}
        @params[:extensions].merge!({type => value})
        self
      end

      def call
        Xapi.create_activity(@params)
      end
    end
  end
end
