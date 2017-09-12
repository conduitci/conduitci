defmodule Conduit.Workspace.Pipeline do
  use Ecto.Schema
  import Ecto.Changeset
  alias Conduit.Workspace.Pipeline

  schema "pipelines" do
    field :name, :string
    belongs_to :pipeline_group, Conduit.Workspace.PipelineGroup

    timestamps()
  end

  @doc false
  def changeset(%Pipeline{} = pipeline, attrs) do
    pipeline
    |> cast(attrs, [:name, :pipeline_group_id])
    |> validate_required([:name, :pipeline_group_id])
  end
end
