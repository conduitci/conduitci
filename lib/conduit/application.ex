defmodule Conduit.Application do
  @moduledoc false
  use Application

  alias ConduitWeb.Endpoint

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Conduit.Repo, []),
      supervisor(ConduitWeb.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Conduit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc false
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
