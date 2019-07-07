require_relative "../db_spec_helper"
require_relative "../../../lib/persistence/entities/article.rb"
require_relative "../../../lib/persistence/repositories/article_repo.rb"

RSpec.describe Persistence::Repositories::ArticleRepo do
  subject(:repo) { described_class.new(Persistence.rom) }

  before(:all) do
    author = Factory[:author, name: "Jane Doe"]
    Factory[:article, title: "First test article", published: true, author_id: author.id]
    Factory[:article, title: "Draft article", published: false, author_id: author.id]
  end

  describe "#listing" do
    it "returns published articles with authors" do
      articles = repo.listing
      expect(articles.length).to eq 1
      expect(articles.first.title).to eq "First test article"
      expect(articles.first.author.name).to eq "Jane Doe"
      expect(articles.first.published).to eq true
    end
  end

  describe "#articles" do
    it "returns published articles without authors" do
      articles = repo.articles.to_a

      expect(articles.length).to eq 1
      expect(articles.first.title).to eq "First test article"
      expect(articles.first.published).to eq true
    end
  end

  describe "#publish" do
    it "creates a published article with author associated" do
      author = Factory[:author, name: "Benny Hill"]
      article_details = { title: "Ruby's Cool" }
      article = repo.publish(author, article_details)

      expect(article.id).not_to be_nil
      expect(article.title).to eq article_details[:title]
      expect(article.published).to eq true
      expect(article.author_id).to eq author.id
    end
  end

  describe "#unpublish" do
    it "changes the article to unpublished" do
      article = repo.first

      # expect(repo)
    end
  end
end
