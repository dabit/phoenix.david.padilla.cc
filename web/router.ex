defmodule Blog.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  #pipeline :api do
    #plug :accepts, ["json"]
  #end

  scope "/", Blog do
    pipe_through :browser # Use the default browser stack

    get "/", PostsController, :index
    get "about-me", AboutMeController, :show
    get "archive", ArchiveController, :index
    resources "posts", PostsController, only: [ :show ]
  end

  scope "admin", Blog.Admin, as: "admin" do
    pipe_through :browser

    get "/", PostsController, :index
    resources "posts", PostsController do
      resource "state", StateController, only: [:update]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Blog do
  #   pipe_through :api
  # end
end
