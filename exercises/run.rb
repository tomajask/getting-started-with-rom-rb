require "bundler/setup"
require "pry"
require "rom-repository"

require_relative "setup"
require_relative "lib/persistence/entities/article.rb"
require_relative "lib/persistence/structs/article.rb"
require_relative "lib/persistence/repositories/author_repo.rb"
require_relative "lib/persistence/repositories/article_repo.rb"

MIGRATION = Persistence.db.migration do
  change do
    create_table :authors do
      primary_key :id
      column :name, :text, null: false
    end

    create_table :articles do
      primary_key :id
      column :title, :text, null: false
      column :published, :boolean, null: false, default: false
      foreign_key :author_id, :authors
    end
  end
end

# TODO: add exercise code here

if $0 == __FILE__
  # Start with a clean database each time
  Persistence.reset_with_migration(MIGRATION)
  Persistence.finalize

  # TODO: play around here ;)

  author_repo = Persistence::Repositories::AuthorRepo.new(Persistence.rom)
  author1 = author_repo.create name: 'Matthew Walker'
  author2 = author_repo.create name: 'Mariusz Max Kolanko'

  article_repo = Persistence::Repositories::ArticleRepo.new(Persistence.rom)
  article1 = article_repo.create title: 'Why we sleep?', published: true, author_id: author1.id
  article2 = article_repo.create title: 'Homo Deus', published: true, author_id: author2.id

  author3 = author_repo.create name: 'TJay'
  article3 = article_repo.publish(author3, { title: 'Rom-rb is on fire!' })
  article_repo.unpublish(article2)

  article1_struct = article_repo.articles.by_pk(article1.id).map_to(Persistence::Structs::Article).one
  article4 = article_repo.create title: 'NoJS', published: false, author_id: author2.id

  binding.pry
end
