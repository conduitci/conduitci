defmodule ConduitWeb.PipelineControllerTest do
  use ConduitWeb.ConnCase

  alias Conduit.Workspace

  @create_attrs %{name: "pipeline name"}
  @update_attrs %{name: "updated pipeline name"}
  @invalid_attrs %{name: nil}
  
  @valid_pipeline_group_attrs %{name: "pipeline group name"}

  def fixture(:pipeline) do
    {:ok, pipeline} = @create_attrs
      |> Enum.into(%{pipeline_group_id: fixture(:pipeline_group).id})
      |> Workspace.create_pipeline()
    pipeline
  end

  def fixture(:pipeline_group) do
    {:ok, pipeline_group} = Workspace.create_pipeline_group(@valid_pipeline_group_attrs)
    
    pipeline_group
  end

  describe "index" do
    test "lists all pipelines", %{conn: conn} do
      conn = get conn, pipeline_path(conn, :index)
      assert html_response(conn, 200) =~ "Pipelines"
    end
  end

  describe "new pipeline" do
    test "renders form", %{conn: conn} do
      conn = get conn, pipeline_path(conn, :new)
      assert html_response(conn, 200) =~ "New Pipeline"
    end
  end

  describe "create pipeline" do
    test "redirects to show when data is valid", %{conn: conn} do
      pipeline_group_id = fixture(:pipeline_group).id
      pipeline_attrs = @create_attrs
        |> Enum.into(%{pipeline_group_id: pipeline_group_id})

      conn = post conn, pipeline_path(conn, :create), pipeline: pipeline_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == pipeline_path(conn, :show, id)

      conn = get conn, pipeline_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Pipeline"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, pipeline_path(conn, :create), pipeline: @invalid_attrs
      assert html_response(conn, 200) =~ "New Pipeline"
    end
  end

  describe "edit pipeline" do
    setup [:create_pipeline]

    test "renders form for editing chosen pipeline", %{conn: conn, pipeline: pipeline} do
      conn = get conn, pipeline_path(conn, :edit, pipeline)
      assert html_response(conn, 200) =~ "Edit Pipeline"
    end
  end

  describe "update pipeline" do
    setup [:create_pipeline]

    test "redirects when data is valid", %{conn: conn, pipeline: pipeline} do
      conn = put conn, pipeline_path(conn, :update, pipeline), pipeline: @update_attrs
      assert redirected_to(conn) == pipeline_path(conn, :show, pipeline)

      conn = get conn, pipeline_path(conn, :show, pipeline)
      assert html_response(conn, 200) =~ @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, pipeline: pipeline} do
      conn = put conn, pipeline_path(conn, :update, pipeline), pipeline: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Pipeline"
    end
  end

  describe "delete pipeline" do
    setup [:create_pipeline]

    test "deletes chosen pipeline", %{conn: conn, pipeline: pipeline} do
      conn = delete conn, pipeline_path(conn, :delete, pipeline)
      assert redirected_to(conn) == pipeline_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, pipeline_path(conn, :show, pipeline)
      end
    end
  end

  defp create_pipeline(_) do
    pipeline = fixture(:pipeline)
    {:ok, pipeline: pipeline}
  end
end
