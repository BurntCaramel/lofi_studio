defmodule LofiPlayWeb.SearchControllerTest do
  use LofiPlayWeb.ConnCase

  alias LofiPlay.Content

  @create_attrs %{query: "some query"}
  @update_attrs %{query: "some updated query"}
  @invalid_attrs %{query: nil}

  def fixture(:search) do
    {:ok, search} = Content.create_search(@create_attrs)
    search
  end

  describe "index" do
    test "lists all search", %{conn: conn} do
      conn = get conn, search_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Search"
    end
  end

  describe "new search" do
    test "renders form", %{conn: conn} do
      conn = get conn, search_path(conn, :new)
      assert html_response(conn, 200) =~ "New Search"
    end
  end

  describe "create search" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, search_path(conn, :create), search: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == search_path(conn, :show, id)

      conn = get conn, search_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Search"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, search_path(conn, :create), search: @invalid_attrs
      assert html_response(conn, 200) =~ "New Search"
    end
  end

  describe "edit search" do
    setup [:create_search]

    test "renders form for editing chosen search", %{conn: conn, search: search} do
      conn = get conn, search_path(conn, :edit, search)
      assert html_response(conn, 200) =~ "Edit Search"
    end
  end

  describe "update search" do
    setup [:create_search]

    test "redirects when data is valid", %{conn: conn, search: search} do
      conn = put conn, search_path(conn, :update, search), search: @update_attrs
      assert redirected_to(conn) == search_path(conn, :show, search)

      conn = get conn, search_path(conn, :show, search)
      assert html_response(conn, 200) =~ "some updated query"
    end

    test "renders errors when data is invalid", %{conn: conn, search: search} do
      conn = put conn, search_path(conn, :update, search), search: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Search"
    end
  end

  describe "delete search" do
    setup [:create_search]

    test "deletes chosen search", %{conn: conn, search: search} do
      conn = delete conn, search_path(conn, :delete, search)
      assert redirected_to(conn) == search_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, search_path(conn, :show, search)
      end
    end
  end

  defp create_search(_) do
    search = fixture(:search)
    {:ok, search: search}
  end
end
