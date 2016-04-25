defmodule Queerlink.Router do
  use Queerlink.Web, :router

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

  scope "/", Queerlink do
    pipe_through :api

    put "/shorten", PageController, :shorten
  end

  scope "/", Queerlink do
    pipe_through :browser

    get "/", PageController, :index
    get "/:uid", PageController, :redirect_url
  end


end
