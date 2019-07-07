module Persistence
  module Repositories
    class ArticleRepo < ROM::Repository[:articles]
      commands :create, update: :by_pk

      struct_namespace Persistence::Entities

      def articles
        root.published
      end

      def listing
        articles.combine(:author).to_a
      end

      def publish(author, article)
        root.changeset(:create, article.to_h.merge(published: true)).associate(author).commit
      end

      def unpublish(article)
        root.by_pk(article.id).changeset(:update, { published: false })
      end

      def query(conditions)
        articles.where(conditions).to_a
      end

      def by_id(id)
        articles.by_pk(id).one
      end

      def first
        articles.limit(1).one
      end

      def last
        articles.order(Sequel.desc(:id)).limit(1).one
      end

      def published
        articles.published.to_a
      end
    end
  end
end

