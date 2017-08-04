defmodule LofiPlayWeb.ScreenController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Screen

  def index(conn, _params) do
    screens = Content.list_screens()
    render(conn, "index.html", screens: screens)
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