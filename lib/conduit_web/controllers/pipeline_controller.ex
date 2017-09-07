defmodule ConduitWeb.PipelineController do
  use ConduitWeb, :controller

  alias Conduit.Workspace
  alias Conduit.Workspace.Pipeline

  def index(conn, _params) do
    pipelines = Workspace.list_pipelines()
    render(conn, "index.html", pipelines: pipelines)
  end

  def new(conn, _params) do
    changeset = Workspace.change_pipeline(%Pipeline{})
    render(
      conn,
      "new.html",
      changeset: changeset,
      pipeline_groups: Enum.map(Workspace.list_pipeline_groups, &{&1.name, &1.id})
    )
  end

  def create(conn, %{"pipeline" => pipeline_params}) do
    case Workspace.create_pipeline(pipeline_params) do
      {:ok, pipeline} ->
        conn
        |> put_flash(:info, "Pipeline created successfully.")
        |> redirect(to: pipeline_path(conn, :show, pipeline))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(
          conn,
          "new.html",
          changeset: changeset,
          pipeline_groups: Enum.map(Workspace.list_pipeline_groups, &{&1.name, &1.id})
        )
    end
  end

  def show(conn, %{"id" => id}) do
    pipeline = Workspace.get_pipeline!(id)
    render(
      conn,
      "show.html",
      pipeline: pipeline,
      pipeline_groups: Enum.map(Workspace.list_pipeline_groups, &{&1.name, &1.id})
    )
  end

  def edit(conn, %{"id" => id}) do
    pipeline = Workspace.get_pipeline!(id)
    changeset = Workspace.change_pipeline(pipeline)
    render(
      conn,
      "edit.html",
      pipeline: pipeline,
      changeset: changeset,
      pipeline_groups: Enum.map(Workspace.list_pipeline_groups, &{&1.name, &1.id})
    )
  end

  def update(conn, %{"id" => id, "pipeline" => pipeline_params}) do
    pipeline = Workspace.get_pipeline!(id)

    case Workspace.update_pipeline(pipeline, pipeline_params) do
      {:ok, pipeline} ->
        conn
        |> put_flash(:info, "Pipeline updated successfully.")
        |> redirect(to: pipeline_path(conn, :show, pipeline))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pipeline: pipeline, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pipeline = Workspace.get_pipeline!(id)
    {:ok, _pipeline} = Workspace.delete_pipeline(pipeline)

    conn
    |> put_flash(:info, "Pipeline deleted successfully.")
    |> redirect(to: pipeline_path(conn, :index))
  end
end
