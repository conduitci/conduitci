defmodule ConduitWeb.StatusController do
  use ConduitWeb, :controller
  
  alias Conduit.Repo
  
  def index(conn, _params) do
    import ConduitWeb.LayoutView, only: [git: 0]
    data =
      %{
        status: "up",
        version: git().commit,
        current_timestamp: DateTime.utc_now(),
      }
      |> Poison.encode!

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end

  def migrate(conn, _params) do
    # Perform migrations
    {:ok, _} = Application.ensure_all_started(:conduit)

    path = Application.app_dir(:conduit, "priv/repo/migrations")

    case Ecto.Migrator.run(Repo, path, :up, all: true) do
      [] -> text conn, "Conduit: No database migrations have been run."
      migrations ->
        migrations = migrations |> Enum.map(&to_string/1) |> Enum.join(", ")

        text conn, "Conduit: The following database migrations have been run #{migrations}."
    end
  end
end
