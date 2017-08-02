defmodule LofiPlayWeb.ScreenControllerTest do
  use LofiPlayWeb.ConnCase

  alias LofiPlay.Content

  @create_attrs %{body: "some body", name: "some name"}
  @update_attrs %{body: "some updated body", name: "some updated name"}
  @invalid_attrs %{body: nil, name: nil}

  def fixture(:screen) do
    {:ok, screen} = Content.create_screen(@create_attrs)
    screen
  end

  describe "index" do
    test "lists all screens", %{conn: conn} do
      conn = get conn, screen_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Screens"
    end
  end

  describe "new screen" do
    test "renders form", %{conn: conn} do
      conn = get conn, screen_path(conn, :new)
      assert html_response(conn, 200) =~ "New Screen"
    end
  end

  describe "create screen" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, screen_path(conn, :create), screen: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == screen_path(conn, :show, id)

      conn = get conn, screen_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Screen"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, screen_path(conn, :create), screen: @invalid_attrs
      assert html_response(conn, 200) =~ "New Screen"
    end
  end

  describe "edit screen" do
    setup [:create_screen]

    test "renders form for editing chosen screen", %{conn: conn, screen: screen} do
      conn = get conn, screen_path(conn, :edit, screen)
      assert html_response(conn, 200) =~ "Edit Screen"
    end
  end

  describe "update screen" do
    setup [:create_screen]

    test "redirects when data is valid", %{conn: conn, screen: screen} do
      conn = put conn, screen_path(conn, :update, screen), screen: @update_attrs
      assert redirected_to(conn) == screen_path(conn, :show, screen)

      conn = get conn, screen_path(conn, :show, screen)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, screen: screen} do
      conn = put conn, screen_path(conn, :update, screen), screen: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Screen"
    end
  end

  describe "delete screen" do
    setup [:create_screen]

    test "deletes chosen screen", %{conn: conn, screen: screen} do
      conn = delete conn, screen_path(conn, :delete, screen)
      assert redirected_to(conn) == screen_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, screen_path(conn, :show, screen)
      end
    end
  end

  defp create_screen(_) do
    screen = fixture(:screen)
    {:ok, screen: screen}
  end
end
