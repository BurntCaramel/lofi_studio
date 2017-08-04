use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lofi_play, LofiPlayWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

import_config "test.secret.exs"
# Example test.secret.exs:
#
# # Configure your database
# config :lofi_play, LofiPlay.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "username",
#   password: "",
#   database: "lofi_play_test",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox