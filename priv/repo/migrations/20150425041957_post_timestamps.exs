defmodule Blog.Repo.Migrations.PostTimestamps do
  use Ecto.Migration

  def change do
    alter table(:miniblog_posts) do
      add :inserted_at, :datetime, default: fragment("now()")
    end
  end
end
