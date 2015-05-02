use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :blog, Blog.Endpoint,
  secret_key_base: "UeRrYWqo8eSNnXgVOIp/mE7oCwHfkZdLqTW5T8/nWMEzpr0ViRRuziA5cZExT1Tn"

# Configure your database
config :blog, Blog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "blog_prod"
