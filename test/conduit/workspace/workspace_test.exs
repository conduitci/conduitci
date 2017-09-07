defmodule Conduit.WorkspaceTest do
  use Conduit.DataCase

  alias Conduit.Workspace

  describe "pipeline_groups" do
    alias Conduit.Workspace.PipelineGroup

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def pipeline_group_fixture(attrs \\ %{}) do
      {:ok, pipeline_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workspace.create_pipeline_group()

      pipeline_group
    end

    test "list_pipeline_groups/0 returns all pipeline_groups" do
      pipeline_group = pipeline_group_fixture()
      assert Workspace.list_pipeline_groups() == [pipeline_group]
    end

    test "get_pipeline_group!/1 returns the pipeline_group with given id" do
      pipeline_group = pipeline_group_fixture()
      assert Workspace.get_pipeline_group!(pipeline_group.id) == pipeline_group
    end

    test "create_pipeline_group/1 with valid data creates a pipeline_group" do
      assert {:ok, %PipelineGroup{} = pipeline_group} = Workspace.create_pipeline_group(@valid_attrs)
      assert pipeline_group.name == "some name"
    end

    test "create_pipeline_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workspace.create_pipeline_group(@invalid_attrs)
    end

    test "update_pipeline_group/2 with valid data updates the pipeline_group" do
      pipeline_group = pipeline_group_fixture()
      assert {:ok, pipeline_group} = Workspace.update_pipeline_group(pipeline_group, @update_attrs)
      assert %PipelineGroup{} = pipeline_group
      assert pipeline_group.name == "some updated name"
    end

    test "update_pipeline_group/2 with invalid data returns error changeset" do
      pipeline_group = pipeline_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Workspace.update_pipeline_group(pipeline_group, @invalid_attrs)
      assert pipeline_group == Workspace.get_pipeline_group!(pipeline_group.id)
    end

    test "delete_pipeline_group/1 deletes the pipeline_group" do
      pipeline_group = pipeline_group_fixture()
      assert {:ok, %PipelineGroup{}} = Workspace.delete_pipeline_group(pipeline_group)
      assert_raise Ecto.NoResultsError, fn -> Workspace.get_pipeline_group!(pipeline_group.id) end
    end

    test "change_pipeline_group/1 returns a pipeline_group changeset" do
      pipeline_group = pipeline_group_fixture()
      assert %Ecto.Changeset{} = Workspace.change_pipeline_group(pipeline_group)
    end
  end

  describe "pipelines" do
    alias Conduit.Workspace.Pipeline

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def pipeline_fixture(attrs \\ %{}) do
      {:ok, pipeline} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workspace.create_pipeline()

      pipeline
    end

    test "list_pipelines/0 returns all pipelines" do
      pipeline = pipeline_fixture()
      assert Workspace.list_pipelines() == [pipeline]
    end

    test "get_pipeline!/1 returns the pipeline with given id" do
      pipeline = pipeline_fixture()
      assert Workspace.get_pipeline!(pipeline.id) == pipeline
    end

    test "create_pipeline/1 with valid data creates a pipeline" do
      assert {:ok, %Pipeline{} = pipeline} = Workspace.create_pipeline(@valid_attrs)
      assert pipeline.name == "some name"
    end

    test "create_pipeline/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workspace.create_pipeline(@invalid_attrs)
    end

    test "update_pipeline/2 with valid data updates the pipeline" do
      pipeline = pipeline_fixture()
      assert {:ok, pipeline} = Workspace.update_pipeline(pipeline, @update_attrs)
      assert %Pipeline{} = pipeline
      assert pipeline.name == "some updated name"
    end

    test "update_pipeline/2 with invalid data returns error changeset" do
      pipeline = pipeline_fixture()
      assert {:error, %Ecto.Changeset{}} = Workspace.update_pipeline(pipeline, @invalid_attrs)
      assert pipeline == Workspace.get_pipeline!(pipeline.id)
    end

    test "delete_pipeline/1 deletes the pipeline" do
      pipeline = pipeline_fixture()
      assert {:ok, %Pipeline{}} = Workspace.delete_pipeline(pipeline)
      assert_raise Ecto.NoResultsError, fn -> Workspace.get_pipeline!(pipeline.id) end
    end

    test "change_pipeline/1 returns a pipeline changeset" do
      pipeline = pipeline_fixture()
      assert %Ecto.Changeset{} = Workspace.change_pipeline(pipeline)
    end
  end
end
