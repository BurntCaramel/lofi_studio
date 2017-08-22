defmodule LofiPlayWeb.ComponentController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Component

  def index(conn, %{"preview" => "1"}) do
    components = Content.list_components()
    render(conn, "index.html", components: components, preview: true)
  end

  def index(conn, _params) do
    components = Content.list_components()
    render(conn, "index.html", components: components, preview: false)
  end

  def new(conn, _params) do
    changeset = Content.change_component(%Component{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"component" => component_params}) do
    case Content.create_component(component_params) do
      {:ok, component} ->
        conn
        |> put_flash(:info, "Component created successfully.")
        |> redirect(to: component_path(conn, :show, component))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    component = Content.get_component!(id)
    render(conn, "show.html", component: component)
  end

  def edit(conn, %{"id" => id}) do
    component = Content.get_component!(id)
    changeset = Content.change_component(component)
    render(conn, "edit.html", component: component, changeset: changeset)
  end

  def update(conn, %{"id" => id, "component" => component_params}) do
    component = Content.get_component!(id)

    case Content.update_component(component, component_params) do
      {:ok, component} ->
        conn
        |> put_flash(:info, "Component updated successfully.")
        |> redirect(to: component_path(conn, :show, component))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", component: component, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    component = Content.get_component!(id)
    {:ok, _component} = Content.delete_component(component)

    conn
    |> put_flash(:info, "Component deleted successfully.")
    |> redirect(to: component_path(conn, :index))
  end
end
