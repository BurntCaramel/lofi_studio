defmodule LofiPlay.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias LofiPlay.Repo

  alias LofiPlay.Content.Screen

  @doc """
  Returns the list of screens.

  ## Examples

      iex> list_screens()
      [%Screen{}, ...]

  """
  def list_screens do
    Repo.all(
      Screen
      #|> order_by(asc: :inserted_at)
      |> order_by(desc: :updated_at)
    )
  end

  @doc """
  Gets a single screen.

  Raises `Ecto.NoResultsError` if the Screen does not exist.

  ## Examples

      iex> get_screen!(123)
      %Screen{}

      iex> get_screen!(456)
      ** (Ecto.NoResultsError)

  """
  def get_screen!(id), do: Repo.get!(Screen, id)

  @doc """
  Creates a screen.

  ## Examples

      iex> create_screen(%{field: value})
      {:ok, %Screen{}}

      iex> create_screen(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_screen(attrs \\ %{}) do
    %Screen{}
    |> Screen.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a screen.

  ## Examples

      iex> update_screen(screen, %{field: new_value})
      {:ok, %Screen{}}

      iex> update_screen(screen, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_screen(%Screen{} = screen, attrs) do
    screen
    |> Screen.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Screen.

  ## Examples

      iex> delete_screen(screen)
      {:ok, %Screen{}}

      iex> delete_screen(screen)
      {:error, %Ecto.Changeset{}}

  """
  def delete_screen(%Screen{} = screen) do
    Repo.delete(screen)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking screen changes.

  ## Examples

      iex> change_screen(screen)
      %Ecto.Changeset{source: %Screen{}}

  """
  def change_screen(%Screen{} = screen) do
    Screen.changeset(screen, %{})
  end

  alias LofiPlay.Content.Schema

  @doc """
  Returns the list of schemas.

  ## Examples

      iex> list_schemas()
      [%Schema{}, ...]

  """
  def list_schemas do
    Repo.all(Schema)
  end

  @doc """
  Gets a single schema.

  Raises `Ecto.NoResultsError` if the Schema does not exist.

  ## Examples

      iex> get_schema!(123)
      %Schema{}

      iex> get_schema!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schema!(id), do: Repo.get!(Schema, id)

  @doc """
  Creates a schema.

  ## Examples

      iex> create_schema(%{field: value})
      {:ok, %Schema{}}

      iex> create_schema(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_schema(attrs \\ %{}) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a schema.

  ## Examples

      iex> update_schema(schema, %{field: new_value})
      {:ok, %Schema{}}

      iex> update_schema(schema, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schema(%Schema{} = schema, attrs) do
    schema
    |> Schema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Schema.

  ## Examples

      iex> delete_schema(schema)
      {:ok, %Schema{}}

      iex> delete_schema(schema)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schema(%Schema{} = schema) do
    Repo.delete(schema)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schema changes.

  ## Examples

      iex> change_schema(schema)
      %Ecto.Changeset{source: %Schema{}}

  """
  def change_schema(%Schema{} = schema) do
    Schema.changeset(schema, %{})
  end
end
