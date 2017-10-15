defmodule LofiPlayWeb.JourneyControllerTest do
  use LofiPlayWeb.ConnCase

  alias LofiPlay.Content

  @create_attrs %{body: "some body", name: "some name"}
  @update_attrs %{body: "some updated body", name: "some updated name"}
  @invalid_attrs %{body: nil, name: nil}

  def fixture(:journey) do
    {:ok, journey} = Content.create_journey(@create_attrs)
    journey
  end

  describe "index" do
    test "lists all journeys", %{conn: conn} do
      conn = get conn, journey_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Journeys"
    end
  end

  describe "new journey" do
    test "renders form", %{conn: conn} do
      conn = get conn, journey_path(conn, :new)
      assert html_response(conn, 200) =~ "New Journey"
    end
  end

  describe "create journey" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, journey_path(conn, :create), journey: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == journey_path(conn, :show, id)

      conn = get conn, journey_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Journey"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, journey_path(conn, :create), journey: @invalid_attrs
      assert html_response(conn, 200) =~ "New Journey"
    end
  end

  describe "edit journey" do
    setup [:create_journey]

    test "renders form for editing chosen journey", %{conn: conn, journey: journey} do
      conn = get conn, journey_path(conn, :edit, journey)
      assert html_response(conn, 200) =~ "Edit Journey"
    end
  end

  describe "update journey" do
    setup [:create_journey]

    test "redirects when data is valid", %{conn: conn, journey: journey} do
      conn = put conn, journey_path(conn, :update, journey), journey: @update_attrs
      assert redirected_to(conn) == journey_path(conn, :show, journey)

      conn = get conn, journey_path(conn, :show, journey)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, journey: journey} do
      conn = put conn, journey_path(conn, :update, journey), journey: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Journey"
    end
  end

  describe "delete journey" do
    setup [:create_journey]

    test "deletes chosen journey", %{conn: conn, journey: journey} do
      conn = delete conn, journey_path(conn, :delete, journey)
      assert redirected_to(conn) == journey_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, journey_path(conn, :show, journey)
      end
    end
  end

  defp create_journey(_) do
    journey = fixture(:journey)
    {:ok, journey: journey}
  end
end
