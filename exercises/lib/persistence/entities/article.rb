module Persistence
  module Entities
    class Article < ROM::Struct
      def title_with_publish
        "'#{title}' is #{published ? 'published' : 'not yet published'}"
      end
    end
  end
end
