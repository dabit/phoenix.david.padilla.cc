defmodule Blog.User do
  use Blog.Web, :model
  import Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    timestamps
  end

  def password_correct?(user, password) do
    checkpw(password, user.encrypted_password)
  end
end
