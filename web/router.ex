defmodule PhoenixLibrary.Router do
  use PhoenixLibrary.Web, :router

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

  scope "/", PhoenixLibrary do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/search", PageController, :index

    resources "/books", BookController, except: [:create, :update, :delete]
  end

  # scope "/api", PhoenixLibrary.Api, as: :api do
  #   pipe_through :api

  #   resources "/books", BookController, except: [:new, :edit]
  # end

end
