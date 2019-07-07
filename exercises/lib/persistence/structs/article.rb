require 'dry-struct'

module Persistence
  module Structs
    module Types
      include Dry.Types()
    end

    class Article < Dry::Struct
      attribute :title,     Types::Strict::String
      attribute :published, Types::Strict::Bool
    end
  end
end
