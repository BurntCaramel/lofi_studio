defmodule LofiPlayWeb.Router do
  use LofiPlayWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LofiPlayWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/journeys", JourneyController do
      resources "/preview", JourneyPreviewController, only: [:show], singleton: true, as: :preview
    end
    resources "/screens", ScreenController do
      resources "/preview", ScreenPreviewController, only: [:show], singleton: true, as: :preview
    end
    resources "/schemas", SchemaController
    resources "/components", ComponentController
  end

  # Other scopes may use custom stacks.
  scope "/api", LofiPlayWeb, as: :api do
    pipe_through :api

    resources "/screens", API.ScreenController, only: [:index, :show]
    resources "/schemas", API.SchemaController, only: [:index, :show] do
      resources "/faker", API.SchemaFakerController, only: [:show], singleton: true, as: :faker
    end
  end
end
