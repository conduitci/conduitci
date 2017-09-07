defmodule Conduit.Repo.Migrations.CreatePipelines do
  use Ecto.Migration

  def change do
    create table(:pipelines) do
      add :name, :string
      add :pipeline_group_id, references(:pipeline_groups, on_delete: :nothing)

      timestamps()
    end

    create index(:pipelines, [:pipeline_group_id])
  end
end
