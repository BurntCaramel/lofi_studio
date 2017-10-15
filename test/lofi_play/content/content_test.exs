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

  describe "components" do
    alias LofiPlay.Content.Component

    @valid_attrs %{body: "some body", name: "some name", tags: "some tags", type: 42}
    @update_attrs %{body: "some updated body", name: "some updated name", tags: "some updated tags", type: 43}
    @invalid_attrs %{body: nil, name: nil, tags: nil, type: nil}

    def component_fixture(attrs \\ %{}) do
      {:ok, component} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_component()

      component
    end

    test "list_components/0 returns all components" do
      component = component_fixture()
      assert Content.list_components() == [component]
    end

    test "get_component!/1 returns the component with given id" do
      component = component_fixture()
      assert Content.get_component!(component.id) == component
    end

    test "create_component/1 with valid data creates a component" do
      assert {:ok, %Component{} = component} = Content.create_component(@valid_attrs)
      assert component.body == "some body"
      assert component.name == "some name"
      assert component.tags == "some tags"
      assert component.type == 42
    end

    test "create_component/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_component(@invalid_attrs)
    end

    test "update_component/2 with valid data updates the component" do
      component = component_fixture()
      assert {:ok, component} = Content.update_component(component, @update_attrs)
      assert %Component{} = component
      assert component.body == "some updated body"
      assert component.name == "some updated name"
      assert component.tags == "some updated tags"
      assert component.type == 43
    end

    test "update_component/2 with invalid data returns error changeset" do
      component = component_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_component(component, @invalid_attrs)
      assert component == Content.get_component!(component.id)
    end

    test "delete_component/1 deletes the component" do
      component = component_fixture()
      assert {:ok, %Component{}} = Content.delete_component(component)
      assert_raise Ecto.NoResultsError, fn -> Content.get_component!(component.id) end
    end

    test "change_component/1 returns a component changeset" do
      component = component_fixture()
      assert %Ecto.Changeset{} = Content.change_component(component)
    end
  end

  describe "journeys" do
    alias LofiPlay.Content.Journey

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def journey_fixture(attrs \\ %{}) do
      {:ok, journey} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_journey()

      journey
    end

    test "list_journeys/0 returns all journeys" do
      journey = journey_fixture()
      assert Content.list_journeys() == [journey]
    end

    test "get_journey!/1 returns the journey with given id" do
      journey = journey_fixture()
      assert Content.get_journey!(journey.id) == journey
    end

    test "create_journey/1 with valid data creates a journey" do
      assert {:ok, %Journey{} = journey} = Content.create_journey(@valid_attrs)
      assert journey.body == "some body"
      assert journey.name == "some name"
    end

    test "create_journey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_journey(@invalid_attrs)
    end

    test "update_journey/2 with valid data updates the journey" do
      journey = journey_fixture()
      assert {:ok, journey} = Content.update_journey(journey, @update_attrs)
      assert %Journey{} = journey
      assert journey.body == "some updated body"
      assert journey.name == "some updated name"
    end

    test "update_journey/2 with invalid data returns error changeset" do
      journey = journey_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_journey(journey, @invalid_attrs)
      assert journey == Content.get_journey!(journey.id)
    end

    test "delete_journey/1 deletes the journey" do
      journey = journey_fixture()
      assert {:ok, %Journey{}} = Content.delete_journey(journey)
      assert_raise Ecto.NoResultsError, fn -> Content.get_journey!(journey.id) end
    end

    test "change_journey/1 returns a journey changeset" do
      journey = journey_fixture()
      assert %Ecto.Changeset{} = Content.change_journey(journey)
    end
  end
end
