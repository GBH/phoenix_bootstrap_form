defmodule PhoenixBootstrapFormTest do
  use ExUnit.Case
  import Phoenix.HTML

  doctest PhoenixBootstrapForm

  setup do
    conn = Phoenix.ConnTest.build_conn()
    form = Phoenix.HTML.FormData.to_form(conn, [as: :record, multipart: true])
    {:ok, [conn: conn, form: form]}
  end

  test "text_input", %{form: form} do
    input = PhoenixBootstrapForm.text_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="text">) <>
      ~s(</div></div>)
  end

  test "file_input", %{form: form} do
    input = PhoenixBootstrapForm.file_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="file">) <>
      ~s(</div></div>)
  end

  test "email_input", %{form: form} do
    input = PhoenixBootstrapForm.email_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="email">) <>
      ~s(</div></div>)
  end

  test "password_input", %{form: form} do
    input = PhoenixBootstrapForm.password_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="password">) <>
      ~s(</div></div>)
  end

  test "textarea", %{form: form} do
    input = PhoenixBootstrapForm.textarea(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<textarea class="form-control " id="record_value" name="record[value]">\n</textarea>) <>
      ~s(</div></div>)
  end

  test "telephone_input", %{form: form} do
    input = PhoenixBootstrapForm.telephone_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="tel">) <>
      ~s(</div></div>)
  end

  test "select", %{form: form} do
    input = PhoenixBootstrapForm.select(form, :value, ["option"])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<select class="form-control " id="record_value" name="record[value]">) <>
      ~s(<option value=\"option\">option</option>) <>
      ~s(</select></div></div>)
  end

  test "checkbox", %{form: form} do
    input = PhoenixBootstrapForm.checkbox(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<div class="col-sm-10 ml-auto">) <>
      ~s(<div class="form-check ">) <>
      ~s(<label class="form-check-label">) <>
      ~s(<input name="record[value]" type="hidden" value="false">) <>
      ~s(<input class="form-check-input" id="record_value" name="record[value]" type="checkbox" value="true">) <>
      ~s(\nValue) <>
      ~s(</label></div></div></div>)
  end

  test "radio_button", %{form: form} do
    input = PhoenixBootstrapForm.radio_button(form, :value, ["red", "green"])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<div class="form-check "><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_green" name="record[value]" type="radio" value="green">) <>
      ~s(\nGreen</label></div>) <>
      ~s(<div class="form-check "><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_red" name="record[value]" type="radio" value="red">) <>
      ~s(\nRed) <>
      ~s(</label></div></div></div>)
  end

  test "radio_button with custom labels", %{form: form} do
    input = PhoenixBootstrapForm.radio_button(form, :value, %{"R" => "red", "G" => "green"})
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<div class="form-check "><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_green" name="record[value]" type="radio" value="green">) <>
      ~s(\nG</label></div>) <>
      ~s(<div class="form-check "><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_red" name="record[value]" type="radio" value="red">) <>
      ~s(\nR) <>
      ~s(</label></div></div></div>)
  end

  test "radio_button with inline", %{form: form} do
    input = PhoenixBootstrapForm.radio_button(form, :value, ["red", "green"], input: [inline: true])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<div class="form-check form-check-inline"><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_green" name="record[value]" type="radio" value="green">) <>
      ~s(\nGreen</label></div>) <>
      ~s(<div class="form-check form-check-inline"><label class="form-check-label">) <>
      ~s(<input class="form-check-input" id="record_value_red" name="record[value]" type="radio" value="red">) <>
      ~s(\nRed) <>
      ~s(</label></div></div></div>)
  end

  test "submit", %{form: form} do
    input = PhoenixBootstrapForm.submit(form)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<div class="col-sm-10 ml-auto">) <>
      ~s(<button class="btn" type="submit">Submit</button>) <>
      ~s(</div></div>)
  end

  test "submit with label", %{form: form} do
    input = PhoenixBootstrapForm.submit(form, "Smash")
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<div class="col-sm-10 ml-auto">) <>
      ~s(<button class="btn" type="submit">Smash</button>) <>
      ~s(</div></div>)
  end

  test "submit with alternative", %{form: form} do
    input = PhoenixBootstrapForm.submit(form, "Smash", alternative: "Cancel")
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<div class="col-sm-10 ml-auto">) <>
      ~s(<button class="btn" type="submit">Smash</button>) <>
      ~s(Cancel) <>
      ~s(</div></div>)
  end

  test "static", %{form: form} do
    input = PhoenixBootstrapForm.static(form, "Label", "Content")
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2">Label</label>) <>
      ~s(<div class="form-control-plaintext col-sm-10">Content</div>) <>
      ~s(</div>)
  end

  test "with custom class", %{form: form} do
    input = PhoenixBootstrapForm.text_input(form, :value, input: [class: "custom"])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control  custom" id="record_value" name="record[value]" type="text">) <>
      ~s(</div></div>)
  end

  test "with custom label", %{form: form} do
    input = PhoenixBootstrapForm.text_input(form, :value, label: [text: "Custom"])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Custom</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="text">) <>
      ~s(</div></div>)
  end

  test "with help attribute", %{form: form} do
    input = PhoenixBootstrapForm.text_input(form, :value, input: [help: "help text"])
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="text">) <>
      ~s(<small class="form-text text-muted">help text</small>) <>
      ~s(</div></div>)
  end

  test "with custom grid", %{conn: conn} do
    opts  = [as: :record, label_col: "col-sm-3", control_col: "col-sm-9", label_align: "text-sm-left"]
    form  = Phoenix.HTML.FormData.to_form(conn, opts)
    input = PhoenixBootstrapForm.text_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-left col-sm-3" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-9">) <>
      ~s(<input class="form-control " id="record_value" name="record[value]" type="text">) <>
      ~s(</div></div>)
  end

  test "with errors", %{form: form} do
    error = [value: {"Some error", []}]
    form = %Phoenix.HTML.Form{form | errors: error}
    input = PhoenixBootstrapForm.text_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control is-invalid" id="record_value" name="record[value]" type="text">) <>
      ~s(<div class="invalid-feedback">Some error</div>) <>
      ~s(</div></div>)
  end
  
  test "with dynamic errors", %{form: form} do
    error = [value: {"Got errors - %{count}", [count: 10]}]
    form = %Phoenix.HTML.Form{form | errors: error}
    input = PhoenixBootstrapForm.text_input(form, :value)
    assert safe_to_string(input) ==
      ~s(<div class="form-group row">) <>
      ~s(<label class="col-form-label text-sm-right col-sm-2" for="record_value">Value</label>) <>
      ~s(<div class="col-sm-10">) <>
      ~s(<input class="form-control is-invalid" id="record_value" name="record[value]" type="text">) <>
      ~s(<div class="invalid-feedback">Got errors - 10</div>) <>
      ~s(</div></div>)
  end
end
