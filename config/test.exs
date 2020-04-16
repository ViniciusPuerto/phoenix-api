use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_app, MyAppWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :my_app, MyApp.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "example",
  database: "my_app_test",
  hostname: "database",
  pool: Ecto.Adapters.SQL.Sandbox
