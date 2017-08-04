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
end
