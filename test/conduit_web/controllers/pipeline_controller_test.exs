defmodule ConduitWeb.PipelineControllerTest do
  use ConduitWeb.ConnCase

  alias Conduit.Workspace

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:pipeline) do
    {:ok, pipeline} = Workspace.create_pipeline(@create_attrs)
    pipeline
  end

  describe "index" do
    test "lists all pipelines", %{conn: conn} do
      conn = get conn, pipeline_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Pipelines"
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
      conn = post conn, pipeline_path(conn, :create), pipeline: @create_attrs

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
      assert html_response(conn, 200) =~ "some updated name"
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
