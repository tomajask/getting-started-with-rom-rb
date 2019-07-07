module Persistence
  module Repositories
    class AuthorRepo < ROM::Repository[:authors]
      commands :create
    end
  end
end

