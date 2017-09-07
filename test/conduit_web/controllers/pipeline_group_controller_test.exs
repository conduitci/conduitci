defmodule ConduitWeb.PipelineGroupControllerTest do
  use ConduitWeb.ConnCase

  alias Conduit.Workspace

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:pipeline_group) do
    {:ok, pipeline_group} = Workspace.create_pipeline_group(@create_attrs)
    pipeline_group
  end

  describe "index" do
    test "lists all pipeline_groups", %{conn: conn} do
      conn = get conn, pipeline_group_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Pipeline groups"
    end
  end

  describe "new pipeline_group" do
    test "renders form", %{conn: conn} do
      conn = get conn, pipeline_group_path(conn, :new)
      assert html_response(conn, 200) =~ "New Pipeline group"
    end
  end

  describe "create pipeline_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, pipeline_group_path(conn, :create), pipeline_group: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == pipeline_group_path(conn, :show, id)

      conn = get conn, pipeline_group_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Pipeline group"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, pipeline_group_path(conn, :create), pipeline_group: @invalid_attrs
      assert html_response(conn, 200) =~ "New Pipeline group"
    end
  end

  describe "edit pipeline_group" do
    setup [:create_pipeline_group]

    test "renders form for editing chosen pipeline_group", %{conn: conn, pipeline_group: pipeline_group} do
      conn = get conn, pipeline_group_path(conn, :edit, pipeline_group)
      assert html_response(conn, 200) =~ "Edit Pipeline group"
    end
  end

  describe "update pipeline_group" do
    setup [:create_pipeline_group]

    test "redirects when data is valid", %{conn: conn, pipeline_group: pipeline_group} do
      conn = put conn, pipeline_group_path(conn, :update, pipeline_group), pipeline_group: @update_attrs
      assert redirected_to(conn) == pipeline_group_path(conn, :show, pipeline_group)

      conn = get conn, pipeline_group_path(conn, :show, pipeline_group)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pipeline_group: pipeline_group} do
      conn = put conn, pipeline_group_path(conn, :update, pipeline_group), pipeline_group: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Pipeline group"
    end
  end

  describe "delete pipeline_group" do
    setup [:create_pipeline_group]

    test "deletes chosen pipeline_group", %{conn: conn, pipeline_group: pipeline_group} do
      conn = delete conn, pipeline_group_path(conn, :delete, pipeline_group)
      assert redirected_to(conn) == pipeline_group_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, pipeline_group_path(conn, :show, pipeline_group)
      end
    end
  end

  defp create_pipeline_group(_) do
    pipeline_group = fixture(:pipeline_group)
    {:ok, pipeline_group: pipeline_group}
  end
end
