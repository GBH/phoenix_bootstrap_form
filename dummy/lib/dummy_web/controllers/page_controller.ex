defmodule DummyWeb.PageController do
  use DummyWeb, :controller

  alias Dummy.Record

  def index(conn, _params) do
    render conn, "index.html", changeset: Record.changeset(%Record{}, %{})
  end
end
