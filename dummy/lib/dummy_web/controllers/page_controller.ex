defmodule DummyWeb.PageController do
  use DummyWeb, :controller

  alias Dummy.Record

  def index(conn, _params) do
    changeset             = Record.changeset(%Record{}, %{})
    changeset_with_error  = %{changeset | action: :insert}
      |> Ecto.Changeset.add_error(:value, "Some error")

    render conn, "index.html", changeset: changeset, changeset_with_error: changeset_with_error
  end
end
