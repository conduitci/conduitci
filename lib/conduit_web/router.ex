defmodule ConduitWeb.Router do
  use ConduitWeb, :router

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

  scope "/", ConduitWeb do
    pipe_through :browser # Use the default browser stack

    get "/status", StatusController, :index
    get "/status/migrate", StatusController, :migrate
    get "/", PageController, :index
    resources "/pipelines", PipelineController
    resources "/pipeline_groups", PipelineGroupController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConduitWeb do
  #   pipe_through :api
  # end
end
