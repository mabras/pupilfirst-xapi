require_relative 'objects/builder'
require_relative 'objects/course'
require_relative 'objects/target'

module PupilfirstXapi
  module Objects
    def self.course(course, uri)
      Course.new.call(course, uri)
    end

    def self.target(target, uri, course_uri)
      Target.new.call(target, uri, course_uri)
    end
  end
end
