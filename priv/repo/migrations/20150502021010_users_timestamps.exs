defmodule Blog.Repo.Migrations.UsersTimestamps do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :inserted_at, :datetime, default: fragment("now()")
    end
  end
end
