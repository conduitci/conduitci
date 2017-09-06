defmodule ConduitWeb.LayoutView do
  use ConduitWeb, :view

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if String.starts_with?(current_path, path) do
      " active"
    else
      nil
    end
  end

  def git, do: Application.fetch_env!(:conduit, :git)
end
