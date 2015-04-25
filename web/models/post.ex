defmodule Blog.Post do
  use Blog.Web, :model

  schema "miniblog_posts" do
    field :title, :string
    field :body, :string
    field :permalink, :string
    field :published_at, :datetime
    field :author_id, :integer
    field :state, :string
    field :publisher_id, :integer
    field :ready_for_review, :boolean
    field :marked_for_review_at, :datetime
    field :cms, :boolean, default: false
    field :category_id, :integer

    timestamps
  end

  def featured do
    query = from posts in Blog.Post,
      select: posts,
      limit: 1

    Blog.Repo.all query
  end

  @required_fields ~w(title)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
