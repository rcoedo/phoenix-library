# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_library,
  ecto_repos: [PhoenixLibrary.Repo]

# Configures the endpoint
config :phoenix_library, PhoenixLibrary.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JX3Ym1qTkKw2DzOC7fU2uf21Vg+nvhwKOIsNYTd3mPLTvDZft5gRp4iPRFN6pmC2",
  render_errors: [view: PhoenixLibrary.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixLibrary.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
