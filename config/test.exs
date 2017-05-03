use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bgmatcher, Bgmatcher.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Faster hashing
config :comeonin, bcrypt_log_rounds: 4

# Configure your database
config :bgmatcher, Bgmatcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bgmatcher_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
