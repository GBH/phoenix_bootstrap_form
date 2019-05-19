defmodule PhoenixBootstrapFormErrorHelperTest do
  use ExUnit.Case
  import Phoenix.HTML

  doctest PhoenixBootstrapForm

  def custom_translate_error({msg, opts}) do
    "#{msg}, #{opts[:count]}"
  end

  setup do
    Application.put_env(
      :phoenix_bootstrap_form,
      :translate_error_function,
      {__MODULE__, :custom_translate_error}
    )

    conn = Phoenix.ConnTest.build_conn()
    form = Phoenix.HTML.FormData.to_form(conn, as: :record, multipart: true)
    {:ok, [conn: conn, form: form]}
  end

  test "custom error helper", %{form: form} do
    error = [value: {"Got errors - %{count}", [count: 10]}]
    form = %Phoenix.HTML.Form{form | errors: error}
    input = PhoenixBootstrapForm.text_input(form, :value)

    assert safe_to_string(input) ==
             ~s(<div class="form-group row">) <>
               ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
               ~s(<div class="col-sm-10">) <>
               ~s(<input class="form-control is-invalid" id="record_value" name="record[value]" type="text">) <>
               ~s(<div class="invalid-feedback">Got errors - %{count}, 10</div>) <>
               ~s(</div></div>)
  end
end
