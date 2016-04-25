use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :queerlink, Queerlink.Endpoint,
  secret_key_base: "JxIdnfk0w5CQ0NAj5QbNS5n/ZhbSxjgS+1jWSlceoN0UoHwOnbgSY2Lr2tRlPlHV"

# Configure your database
config :queerlink, Queerlink.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "queerlink_prod",
  pool_size: 20
