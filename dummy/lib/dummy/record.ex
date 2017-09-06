defmodule Dummy.Record do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dummy.Record


  schema "records" do
    field :value, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(%Record{} = record, attrs) do
    record
    |> cast(attrs, [])
    |> validate_required([])
  end
end
