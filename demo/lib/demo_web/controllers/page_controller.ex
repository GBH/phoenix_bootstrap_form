defmodule DemoWeb.PageController do
  use DemoWeb, :controller

  alias Demo.Record

  def index(conn, _params) do
    changeset             = Record.changeset(%Record{}, %{})
    changeset_with_error  = %{changeset | action: :insert}
      |> Ecto.Changeset.add_error(:error_value, "Some error")

    render conn, "index.html", changeset: changeset, changeset_with_error: changeset_with_error
  end
end
