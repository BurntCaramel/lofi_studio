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
    resources "/screens", ScreenController
    resources "/schemas", SchemaController
  end

  # Other scopes may use custom stacks.
  scope "/api", LofiPlayWeb do
    pipe_through :api

    resources "/screens", API.ScreenController, only: [:index, :show]
    resources "/schemas", API.SchemaController, only: [:index, :show]
  end
end
