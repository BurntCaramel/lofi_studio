defmodule LofiPlay.ContentTest do
  use LofiPlay.DataCase

  alias LofiPlay.Content

  describe "screens" do
    alias LofiPlay.Content.Screen

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def screen_fixture(attrs \\ %{}) do
      {:ok, screen} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_screen()

      screen
    end

    test "list_screens/0 returns all screens" do
      screen = screen_fixture()
      assert Content.list_screens() == [screen]
    end

    test "get_screen!/1 returns the screen with given id" do
      screen = screen_fixture()
      assert Content.get_screen!(screen.id) == screen
    end

    test "create_screen/1 with valid data creates a screen" do
      assert {:ok, %Screen{} = screen} = Content.create_screen(@valid_attrs)
      assert screen.body == "some body"
      assert screen.name == "some name"
    end

    test "create_screen/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_screen(@invalid_attrs)
    end

    test "update_screen/2 with valid data updates the screen" do
      screen = screen_fixture()
      assert {:ok, screen} = Content.update_screen(screen, @update_attrs)
      assert %Screen{} = screen
      assert screen.body == "some updated body"
      assert screen.name == "some updated name"
    end

    test "update_screen/2 with invalid data returns error changeset" do
      screen = screen_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_screen(screen, @invalid_attrs)
      assert screen == Content.get_screen!(screen.id)
    end

    test "delete_screen/1 deletes the screen" do
      screen = screen_fixture()
      assert {:ok, %Screen{}} = Content.delete_screen(screen)
      assert_raise Ecto.NoResultsError, fn -> Content.get_screen!(screen.id) end
    end

    test "change_screen/1 returns a screen changeset" do
      screen = screen_fixture()
      assert %Ecto.Changeset{} = Content.change_screen(screen)
    end
  end

  describe "schemas" do
    alias LofiPlay.Content.Schema

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def schema_fixture(attrs \\ %{}) do
      {:ok, schema} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_schema()

      schema
    end

    test "list_schemas/0 returns all schemas" do
      schema = schema_fixture()
      assert Content.list_schemas() == [schema]
    end

    test "get_schema!/1 returns the schema with given id" do
      schema = schema_fixture()
      assert Content.get_schema!(schema.id) == schema
    end

    test "create_schema/1 with valid data creates a schema" do
      assert {:ok, %Schema{} = schema} = Content.create_schema(@valid_attrs)
      assert schema.body == "some body"
      assert schema.name == "some name"
    end

    test "create_schema/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_schema(@invalid_attrs)
    end

    test "update_schema/2 with valid data updates the schema" do
      schema = schema_fixture()
      assert {:ok, schema} = Content.update_schema(schema, @update_attrs)
      assert %Schema{} = schema
      assert schema.body == "some updated body"
      assert schema.name == "some updated name"
    end

    test "update_schema/2 with invalid data returns error changeset" do
      schema = schema_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_schema(schema, @invalid_attrs)
      assert schema == Content.get_schema!(schema.id)
    end

    test "delete_schema/1 deletes the schema" do
      schema = schema_fixture()
      assert {:ok, %Schema{}} = Content.delete_schema(schema)
      assert_raise Ecto.NoResultsError, fn -> Content.get_schema!(schema.id) end
    end

    test "change_schema/1 returns a schema changeset" do
      schema = schema_fixture()
      assert %Ecto.Changeset{} = Content.change_schema(schema)
    end
  end
end
