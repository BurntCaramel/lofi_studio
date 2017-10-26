defmodule LofiPlayWeb.ScreenController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Screen
  alias LofiPlay.Content.Search

  defp clean_query(query), do: String.trim(query)

  defp search_changeset_for_query("") do
    Search.changeset(%Search{}, %{})
  end

  defp search_changeset_for_query(query) do
    Search.changeset(%Search{}, %{"q" => query})
  end

  def index(conn, %{"q" => query}) do
    query = clean_query(query)
    screens = case query do
      "" ->
        Content.list_screens()
      query ->
        Content.search_screens(query)
    end
    search_changeset = search_changeset_for_query(query)
    render(conn, "index.html", screens: screens, search_changeset: search_changeset)
  end

  def index(conn, _params) do
    screens = Content.list_screens()
    search_changeset = search_changeset_for_query("")
    render(conn, "index.html", screens: screens, search_changeset: search_changeset)
  end

  def new(conn, _params) do
    changeset = Content.change_screen(%Screen{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"screen" => screen_params}) do
    case Content.create_screen(screen_params) do
      {:ok, screen} ->
        conn
        |> put_flash(:info, "Screen created successfully.")
        |> redirect(to: screen_path(conn, :show, screen))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    screen = Content.get_screen!(id)
    render(conn, "show.html", screen: screen)
  end

  def edit(conn, %{"id" => id}) do
    screen = Content.get_screen!(id)
    changeset = Content.change_screen(screen)
    render(conn, "edit.html", screen: screen, changeset: changeset)
  end

  def update(conn, %{"id" => id, "screen" => screen_params}) do
    screen = Content.get_screen!(id)

    case Content.update_screen(screen, screen_params) do
      {:ok, screen} ->
        conn
        |> put_flash(:info, "Screen updated successfully.")
        |> redirect(to: screen_path(conn, :show, screen))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", screen: screen, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    screen = Content.get_screen!(id)
    {:ok, _screen} = Content.delete_screen(screen)

    conn
    |> put_flash(:info, "Screen deleted successfully.")
    |> redirect(to: screen_path(conn, :index))
  end
end

defmodule LofiPlayWeb.ScreenPreviewController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Screen
  alias LofiPlay.Preview

  plug :put_view, LofiPlayWeb.ScreenView

  def show(conn, %{"screen_id" => id, "layout" => layout}) do
    screen = Content.get_screen!(id)
    components = Content.list_components()

    conn
    |> put_layout({LofiPlayWeb. LayoutView, "#{layout}.html"})
    |> render("show_preview.html", screen: screen, components: components)
  end

  # Default to Bootstrap 3
  def show(conn, %{"screen_id" => id}) do
    show(conn, %{"screen_id" => id, "layout" => "bootstrap3"})
  end
end
