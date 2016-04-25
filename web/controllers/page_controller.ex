defmodule Queerlink.PageController do
  use Queerlink.Web, :controller
  require Logger

  def index(conn, _params) do
    text(conn, "Hello world.")
  end

  def redirect_url(conn, %{"uid" => uid}) do
    case Queerlink.Shortener.get_url(uid) do
      {:ok, url} -> conn |> redirect(external: url)
      {:error, :not_found} -> render(conn, "not_found.html")
    end
  end

  def shorten(conn, %{"url" => url}) do
    data = case url |> URI.parse |> validate_host do
      {:error, :invalid_url} ->
        %{:status => "error", :data => "Invalid URL"}
      {:error, :localhost} ->
        %{:status => "error", :data => "localhost is not an authorized domain"}
      _ ->
        url |> Queerlink.Shortener.put_url |> s_parse
    end 
    json(conn, data)
  end

  defp s_parse({:ok, {:ok, uid}}), do: s_parse({:ok, uid})
  defp s_parse({:ok, uid})  when is_binary(uid) do 
    page_url(Queerlink.Endpoint, :redirect_url, uid)
  end

  defp validate_host(uri) do
    case uri.host do
      "127.0" <> _foo ->
        {:error, :localhost}
      "localhost" ->
        {:error, :localhost}
      "::1" ->
        {:error, :localhost}
      nil ->
        validate_scheme(uri)
      _ ->
        URI.to_string(uri)
    end
  end

  defp validate_scheme(uri) do
    case uri.scheme do
      "magnet" ->
        URI.to_string(uri)
      _ -> {:error, :invalid_url}
    end
  end
end
