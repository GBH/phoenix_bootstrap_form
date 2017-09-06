# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dummy,
  ecto_repos: [Dummy.Repo]

# Configures the endpoint
config :dummy, DummyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JkhpdeK2FesL1TMCWZ89olkg6Kj71KIkE5RH7q+qcvs0bfDAFhQWNKYYUq4NMTI9",
  render_errors: [view: DummyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dummy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
