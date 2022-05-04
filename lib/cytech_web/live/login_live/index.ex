defmodule CytechWeb.LoginLive.Index do
  use CytechWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
