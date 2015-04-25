defmodule Blog.Post do
  use Blog.Web, :model

  schema "miniblog_posts" do
    belongs_to :category, Blog.Category

    field :title, :string
    field :body, :string
    field :permalink, :string
    field :published_at, Ecto.DateTime
    field :author_id, :integer
    field :state, :string
    field :publisher_id, :integer
    field :ready_for_review, :boolean
    field :marked_for_review_at, :datetime
    field :cms, :boolean, default: false

    timestamps
  end

  def featured do
    query = from p in Blog.Post,
      select: p,
      left_join: c in assoc(p, :category),
      limit: 1,
      preload: [category: c],
      where: not p.cms and p.state == "published",
      order_by: [ desc: p.published_at ]

    List.first Blog.Repo.all query
  end

  def more_to_read do
    query = from p in Blog.Post,
      select: p,
      left_join: c in assoc(p, :category),
      offset: 1,
      limit: 5,
      preload: [category: c],
      where: not p.cms and p.state == "published",
      order_by: [ desc: p.published_at ]

    Blog.Repo.all query
  end

  def published do
    true
  end

  def format_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Timex.Date.from(date)
    |> Timex.DateFormat.format!( "%B %e, %Y", :strftime)
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
