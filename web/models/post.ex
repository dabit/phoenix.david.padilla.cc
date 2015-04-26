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

  def post_query do
    query = from p in Blog.Post,
      select: p,
      left_join: c in assoc(p, :category),
      preload: [category: c],
      where: not p.cms and p.state == "published",
      order_by: [ desc: p.published_at ]
  end

  def featured do
    query = from p in post_query,
      limit: 1

    query |> Blog.Repo.one
  end

  def more_to_read_past(current_post) do
    query = from p in post_query,
      offset: 1,
      limit: 3,
      where: p.published_at < ^current_post.published_at

    query |> Blog.Repo.all
  end

  def more_to_read_future(current_post) do
    query = from p in post_query,
      limit: 3,
      where: p.published_at > ^current_post.published_at

    query |> Blog.Repo.all
  end

  def published do
    true
  end

  def format_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Timex.Date.from(date)
    |> Timex.DateFormat.format!( "%B %e, %Y", :strftime)
  end

  def permalink_to_id(permalink) do
    {id, _} = Integer.parse(permalink)
    id
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
