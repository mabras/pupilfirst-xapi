module PupilfirstXapi
  module Objects
    class Certificate
      def call(issued_certificate, uri_for)
        issued_certificate_uri = uri_for.call(issued_certificate)

        Builder.new(
          id: issued_certificate_uri,
          type: "https://www.opigno.org/en/tincan_registry/activity_type/certificate",
          name: issued_certificate.certificate.name,
          description: issued_certificate.course.description
        ).call
      end
    end
  end
end
