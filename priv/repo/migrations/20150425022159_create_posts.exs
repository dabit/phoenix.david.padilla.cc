defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :permalink, :string
      add :published_at, :datetime
      add :author_id, :integer
      add :state, :string
      add :publisher_id, :integer
      add :ready_for_review, :boolean
      add :marked_for_review_at, :datetime
      add :cms, :boolean, default: false
      add :category_id, :integer

      timestamps
    end
  end
end
