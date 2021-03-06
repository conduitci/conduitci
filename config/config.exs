# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

defmodule Config do
  def get_env(env, default \\ nil) do
    case Mix.env do
      :prod -> "${#{env}}"
      _ -> System.get_env(env) || default
    end
  end
end

# General application configuration
config :conduit,
  ecto_repos: [Conduit.Repo]

# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "104dE8rbg9rVHXA+1j84wwF8fqWktE/Yi3K6s99yhw8UKHlcEoMILmIQoPCXDKQ+",
  render_errors: [view: ConduitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Conduit.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

git_branch =
  Config.get_env("GIT_COMMIT") ||
    System.cmd("git", ~w(rev-parse --abbrev-ref HEAD))
    |> elem(0)
    |> String.trim

git_commit =
  Config.get_env("GIT_COMMIT") ||
    System.cmd("git", ~w(rev-parse HEAD))
    |> elem(0)
    |> String.trim

config :conduit,
  git: %{
    commit: git_commit,
    branch: git_branch
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
