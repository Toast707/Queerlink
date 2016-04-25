defmodule Queerlink.Supervisor do
use Supervisor
require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Logger.info(IO.ANSI.green <> "Supervisor started." <> IO.ANSI.reset)
    children = [
      supervisor(Queerlink.Endpoint, []),
      supervisor(Queerlink.Repo, []),
      worker(Queerlink.Shortener, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
