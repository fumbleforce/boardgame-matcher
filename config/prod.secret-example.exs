use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :bgmatcher, Bgmatcher.Web.Endpoint,
  secret_key_base: "secretkeybasei123123123"

# Configure your database
config :bgmatcher, Bgmatcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgresusername",
  password: "postgrespassword",
  database: "databasename",
  pool_size: 15
