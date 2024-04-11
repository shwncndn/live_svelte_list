defmodule LiveSvelteList.Repo do
  use Ecto.Repo,
    otp_app: :live_svelte_list,
    adapter: Ecto.Adapters.Postgres
end
