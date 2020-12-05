defmodule Skore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Skore.Repo,
      # Start the Telemetry supervisor
      SkoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Skore.PubSub},
      # Start the Endpoint (http/https)
      SkoreWeb.Endpoint
      # Start a worker by calling: Skore.Worker.start_link(arg)
      # {Skore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SkoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
