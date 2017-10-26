defmodule LofiPlayWeb.ComponentController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Component
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
    components = case query do
      "" ->
        Content.list_components()
      query ->
        Content.search_components(query)
    end
    search_changeset = search_changeset_for_query(query)
    render(conn, "index.html", components: components, search_changeset: search_changeset, preview: false)
  end

  def index(conn, %{"details" => "1"}) do
    components = Content.list_components()
    search_changeset = search_changeset_for_query("")
    render(conn, "index.html", components: components, search_changeset: search_changeset, preview: false)
  end

  def index(conn, _params) do
    components = Content.list_components()
    search_changeset = search_changeset_for_query("")
    render(conn, "index.html", components: components, search_changeset: search_changeset, preview: true)
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
