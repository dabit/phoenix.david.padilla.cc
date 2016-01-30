defmodule Blog.User do
  use Ecto.Model
  import Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps
  end

  def authenticate?(user_param) do
    query = from u in Blog.User,
      where: u.email == ^user_param.changes.email

    user = Blog.Repo.one query

    if user && password_correct?(user, user_param.changes.password) do
      user
    else
      nil
    end
  end

  def password_correct?(user, password) do
    checkpw(password, user.encrypted_password)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email), ~w(password))
  end
end
