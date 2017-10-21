defmodule LofiPlayWeb.JourneyController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Journey

  def index(conn, _params) do
    journeys = Content.list_journeys()
    render(conn, "index.html", journeys: journeys)
  end

  def new(conn, _params) do
    changeset = Content.change_journey(%Journey{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"journey" => journey_params}) do
    case Content.create_journey(journey_params) do
      {:ok, journey} ->
        conn
        |> put_flash(:info, "Journey created successfully.")
        |> redirect(to: journey_path(conn, :show, journey))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    journey = Content.get_journey!(id)
    render(conn, "show.html", journey: journey)
  end

  def edit(conn, %{"id" => id}) do
    journey = Content.get_journey!(id)
    changeset = Content.change_journey(journey)
    render(conn, "edit.html", journey: journey, changeset: changeset)
  end

  def update(conn, %{"id" => id, "journey" => journey_params}) do
    journey = Content.get_journey!(id)

    case Content.update_journey(journey, journey_params) do
      {:ok, journey} ->
        conn
        |> put_flash(:info, "Journey updated successfully.")
        |> redirect(to: journey_path(conn, :show, journey))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", journey: journey, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    journey = Content.get_journey!(id)
    {:ok, _journey} = Content.delete_journey(journey)

    conn
    |> put_flash(:info, "Journey deleted successfully.")
    |> redirect(to: journey_path(conn, :index))
  end
end

defmodule LofiPlayWeb.JourneyPreviewController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Journey
  alias LofiPlay.Preview

  plug :put_view, LofiPlayWeb.JourneyView

  def show(conn, %{"journey_id" => id, "layout" => layout}) do
    journey = Content.get_journey!(id)
    components = Content.list_components()

    conn
    |> put_layout({LofiPlayWeb. LayoutView, "#{layout}.html"})
    |> render("show_preview.html", journey: journey, components: components)
  end

  # Default to Bootstrap 3
  def show(conn, %{"journey_id" => id}) do
    show(conn, %{"journey_id" => id, "layout" => "bootstrap4"})
  end
end
