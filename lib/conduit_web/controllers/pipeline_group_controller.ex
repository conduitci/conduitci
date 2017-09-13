defmodule ConduitWeb.PipelineGroupController do
  use ConduitWeb, :controller

  alias Conduit.Workspace
  alias Conduit.Workspace.PipelineGroup

  def index(conn, _params) do
    pipeline_groups = Workspace.list_pipeline_groups()
    render(conn, "index.html", pipeline_groups: pipeline_groups)
  end

  def new(conn, _params) do
    changeset = Workspace.change_pipeline_group(%PipelineGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pipeline_group" => pipeline_group_params}) do
    case Workspace.create_pipeline_group(pipeline_group_params) do
      {:ok, pipeline_group} ->
        conn
        |> put_flash(:info, "Pipeline group created successfully.")
        |> redirect(to: pipeline_group_path(conn, :show, pipeline_group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pipeline_group = Workspace.get_pipeline_group!(id)
    render(conn, "show.html", pipeline_group: pipeline_group)
  end

  def edit(conn, %{"id" => id}) do
    pipeline_group = Workspace.get_pipeline_group!(id)
    changeset = Workspace.change_pipeline_group(pipeline_group)
    render(conn, "edit.html", pipeline_group: pipeline_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pipeline_group" => pipeline_group_params}) do
    pipeline_group = Workspace.get_pipeline_group!(id)

    case Workspace.update_pipeline_group(pipeline_group, pipeline_group_params) do
      {:ok, pipeline_group} ->
        conn
        |> put_flash(:info, "Pipeline group updated successfully.")
        |> redirect(to: pipeline_group_path(conn, :show, pipeline_group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pipeline_group: pipeline_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pipeline_group = Workspace.get_pipeline_group!(id)
    {:ok, _pipeline_group} = Workspace.delete_pipeline_group(pipeline_group)

    conn
    |> put_flash(:info, "Pipeline group deleted successfully.")
    |> redirect(to: pipeline_group_path(conn, :index))
  end
end
