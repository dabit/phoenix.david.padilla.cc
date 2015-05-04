defmodule Blog.DateFormatter do
  def post(date) do
    date
    |> ecto_to_timex
    |> Timex.DateFormat.format!( "%B %e, %Y", :strftime)
  end

  def sitemap(date) do
    date
    |> ecto_to_timex
    |> Timex.DateFormat.format!( "%Y-%m-%dT%H:%M%:z", :strftime)
  end

  def ecto_to_timex(date) do
    elem(Ecto.DateTime.dump(date), 1)
    |> Timex.Date.from
  end
end
