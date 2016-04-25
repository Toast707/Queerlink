defmodule Queerlink do
  use Application

  def start(_type, _args) do
    Queerlink.Supervisor.start_link
  end

  def config_change(changed, _new, removed) do
    Queerlink.Endpoint.config_change(changed, removed)
    :ok
  end
end
