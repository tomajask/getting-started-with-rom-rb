module Persistence
  module Relations
    class Authors < ROM::Relation[:sql]
      schema(:authors, infer: true) do
        associations do
          has_many :articles
        end
      end
    end
  end
end

