defmodule Conduit.Workspace do
  @moduledoc """
  The Workspace context.
  """

  import Ecto.Query, warn: false
  alias Conduit.Repo

  alias Conduit.Workspace.PipelineGroup

  @doc """
  Returns the list of pipeline_groups.

  ## Examples

      iex> list_pipeline_groups()
      [%PipelineGroup{}, ...]

  """
  def list_pipeline_groups do
    Repo.all(PipelineGroup)
  end

  @doc """
  Gets a single pipeline_group.

  Raises `Ecto.NoResultsError` if the Pipeline group does not exist.

  ## Examples

      iex> get_pipeline_group!(123)
      %PipelineGroup{}

      iex> get_pipeline_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pipeline_group!(id), do: Repo.get!(PipelineGroup, id)

  @doc """
  Creates a pipeline_group.

  ## Examples

      iex> create_pipeline_group(%{field: value})
      {:ok, %PipelineGroup{}}

      iex> create_pipeline_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pipeline_group(attrs \\ %{}) do
    %PipelineGroup{}
    |> PipelineGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pipeline_group.

  ## Examples

      iex> update_pipeline_group(pipeline_group, %{field: new_value})
      {:ok, %PipelineGroup{}}

      iex> update_pipeline_group(pipeline_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pipeline_group(%PipelineGroup{} = pipeline_group, attrs) do
    pipeline_group
    |> PipelineGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PipelineGroup.

  ## Examples

      iex> delete_pipeline_group(pipeline_group)
      {:ok, %PipelineGroup{}}

      iex> delete_pipeline_group(pipeline_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pipeline_group(%PipelineGroup{} = pipeline_group) do
    Repo.delete(pipeline_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pipeline_group changes.

  ## Examples

      iex> change_pipeline_group(pipeline_group)
      %Ecto.Changeset{source: %PipelineGroup{}}

  """
  def change_pipeline_group(%PipelineGroup{} = pipeline_group) do
    PipelineGroup.changeset(pipeline_group, %{})
  end

  alias Conduit.Workspace.Pipeline

  @doc """
  Returns the list of pipelines.

  ## Examples

      iex> list_pipelines()
      [%Pipeline{}, ...]

  """
  def list_pipelines do
    Repo.all(Pipeline)
  end

  @doc """
  Gets a single pipeline.

  Raises `Ecto.NoResultsError` if the Pipeline does not exist.

  ## Examples

      iex> get_pipeline!(123)
      %Pipeline{}

      iex> get_pipeline!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pipeline!(id), do: Repo.get!(Pipeline, id)

  @doc """
  Creates a pipeline.

  ## Examples

      iex> create_pipeline(%{field: value})
      {:ok, %Pipeline{}}

      iex> create_pipeline(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pipeline(attrs \\ %{}) do
    %Pipeline{}
    |> Pipeline.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pipeline.

  ## Examples

      iex> update_pipeline(pipeline, %{field: new_value})
      {:ok, %Pipeline{}}

      iex> update_pipeline(pipeline, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pipeline(%Pipeline{} = pipeline, attrs) do
    pipeline
    |> Pipeline.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Pipeline.

  ## Examples

      iex> delete_pipeline(pipeline)
      {:ok, %Pipeline{}}

      iex> delete_pipeline(pipeline)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pipeline(%Pipeline{} = pipeline) do
    Repo.delete(pipeline)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pipeline changes.

  ## Examples

      iex> change_pipeline(pipeline)
      %Ecto.Changeset{source: %Pipeline{}}

  """
  def change_pipeline(%Pipeline{} = pipeline) do
    Pipeline.changeset(pipeline, %{})
  end
end
