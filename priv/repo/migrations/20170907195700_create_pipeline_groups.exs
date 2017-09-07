defmodule Conduit.Repo.Migrations.CreatePipelineGroups do
  use Ecto.Migration

  def change do
    create table(:pipeline_groups) do
      add :name, :string

      timestamps()
    end

  end
end
