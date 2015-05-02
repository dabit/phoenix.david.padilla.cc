defmodule Blog.User do
  use Blog.Web, :model
  import Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    timestamps
  end

  def authenticate?(email, password) do
    query = from u in Blog.User,
      where: u.email == ^email

    user = Blog.Repo.one query

    if user && password_correct?(user, password) do
      user
    else
      nil
    end
  end

  def password_correct?(user, password) do
    checkpw(password, user.encrypted_password)
  end
end
