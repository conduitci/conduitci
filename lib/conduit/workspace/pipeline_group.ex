defmodule Conduit.Workspace.PipelineGroup do
  use Ecto.Schema
  import Ecto.Changeset
  alias Conduit.Workspace.PipelineGroup


  schema "pipeline_groups" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%PipelineGroup{} = pipeline_group, attrs) do
    pipeline_group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
