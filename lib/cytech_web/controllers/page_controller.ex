defmodule CytechWeb.PageController do
  use CytechWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
