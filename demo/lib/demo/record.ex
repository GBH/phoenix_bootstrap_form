defmodule Demo.Record do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Record

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
