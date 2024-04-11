defmodule LiveSvelteList.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveSvelteListWeb.Telemetry,
      LiveSvelteList.Repo,
      {DNSCluster, query: Application.get_env(:live_svelte_list, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveSvelteList.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveSvelteList.Finch},
      # Start a worker by calling: LiveSvelteList.Worker.start_link(arg)
      # {LiveSvelteList.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveSvelteListWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveSvelteList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveSvelteListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
