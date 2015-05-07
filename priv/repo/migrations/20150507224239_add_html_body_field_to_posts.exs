defmodule Blog.Repo.Migrations.AddHtmlBodyFieldToPosts do
  use Ecto.Migration

  def change do
    alter table(:miniblog_posts) do
      add :html_body, :text
    end
  end
end
