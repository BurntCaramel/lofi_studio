defmodule LofiPlayWeb.SchemaControllerTest do
  use LofiPlayWeb.ConnCase

  alias LofiPlay.Content

  @create_attrs %{body: "some body", name: "some name"}
  @update_attrs %{body: "some updated body", name: "some updated name"}
  @invalid_attrs %{body: nil, name: nil}

  def fixture(:schema) do
    {:ok, schema} = Content.create_schema(@create_attrs)
    schema
  end

  describe "index" do
    test "lists all schemas", %{conn: conn} do
      conn = get conn, schema_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Schemas"
    end
  end

  describe "new schema" do
    test "renders form", %{conn: conn} do
      conn = get conn, schema_path(conn, :new)
      assert html_response(conn, 200) =~ "New Schema"
    end
  end

  describe "create schema" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, schema_path(conn, :create), schema: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == schema_path(conn, :show, id)

      conn = get conn, schema_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Schema"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, schema_path(conn, :create), schema: @invalid_attrs
      assert html_response(conn, 200) =~ "New Schema"
    end
  end

  describe "edit schema" do
    setup [:create_schema]

    test "renders form for editing chosen schema", %{conn: conn, schema: schema} do
      conn = get conn, schema_path(conn, :edit, schema)
      assert html_response(conn, 200) =~ "Edit Schema"
    end
  end

  describe "update schema" do
    setup [:create_schema]

    test "redirects when data is valid", %{conn: conn, schema: schema} do
      conn = put conn, schema_path(conn, :update, schema), schema: @update_attrs
      assert redirected_to(conn) == schema_path(conn, :show, schema)

      conn = get conn, schema_path(conn, :show, schema)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, schema: schema} do
      conn = put conn, schema_path(conn, :update, schema), schema: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Schema"
    end
  end

  describe "delete schema" do
    setup [:create_schema]

    test "deletes chosen schema", %{conn: conn, schema: schema} do
      conn = delete conn, schema_path(conn, :delete, schema)
      assert redirected_to(conn) == schema_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, schema_path(conn, :show, schema)
      end
    end
  end

  defp create_schema(_) do
    schema = fixture(:schema)
    {:ok, schema: schema}
  end
end
