defmodule PhoenixBootstrapForm do
  alias Phoenix.HTML
  alias Phoenix.HTML.{Tag, Form}

  @label_col_class "col-sm-2"
  @control_col_class "col-sm-10"
  @label_align_class "text-sm-right"
  @form_group_class "form-group row"

  def select(form = %Form{}, field, options, opts \\ []) do
    draw_generic_input(:select, form, field, options, opts)
  end

  [:text_input, :file_input, :email_input, :password_input, :textarea, :telephone_input]
  |> Enum.each(fn method ->
    def unquote(method)(form = %Form{}, field, opts \\ []) when is_atom(field) do
      draw_generic_input(unquote(method), form, field, nil, opts)
    end
  end)

  def checkbox(form = %Form{}, field, opts \\ []) do
    {label_opts, opts} = Keyword.pop(opts, :label, [])
    {input_opts, _} = Keyword.pop(opts, :input, [])
    {help, input_opts} = Keyword.pop(input_opts, :help)

    label = Keyword.get(label_opts, :text, Form.humanize(field))

    checkbox =
      Form.checkbox(form, field, class: "form-check-input " <> is_valid_class(form, field))

    for_attr = Form.input_id(form, field)
    help = draw_help(help)
    error = draw_error_message(get_error(form, field))

    content =
      Tag.content_tag :div, class: "#{control_col_class(form)} ml-auto" do
        [
          draw_form_check(checkbox, label, for_attr, error, input_opts[:inline]),
          help
        ]
      end

    draw_form_group("", content)
  end

  def checkboxes(form = %Form{}, field, values, opts \\ []) when is_list(values) do
    values = add_labels_to_values(values)

    {input_opts, opts} = Keyword.pop(opts, :input, [])
    {help, input_opts} = Keyword.pop(input_opts, :help)
    {selected, opts} = Keyword.pop(opts, :selected, [])

    input_id = Form.input_id(form, field)
    help = draw_help(help)
    error = draw_error_message(get_error(form, field))

    inputs =
      values
      |> Enum.with_index()
      |> Enum.map(fn {{label, value}, index} ->
        value = elem(HTML.html_escape(value), 1)

        # error needs to show up only on last element
        input_error =
          if(Enum.count(values) - 1 == index) do
            error
          else
            ""
          end

        input_class = "form-check-input " <> is_valid_class(form, field)

        value_id = value |> String.replace(~r/\s/, "")
        input_id = input_id <> "_" <> value_id

        input =
          Tag.tag(
            :input,
            name: Form.input_name(form, field) <> "[]",
            id: input_id,
            type: "checkbox",
            value: value,
            class: input_class,
            checked: Enum.member?(selected, value)
          )

        draw_form_check(
          input,
          label,
          input_id,
          input_error,
          input_opts[:inline]
        )
      end)

    content =
      Tag.content_tag :div, class: "#{control_col_class(form)}" do
        [inputs, help]
      end

    opts = Keyword.put_new(opts, :label, [])
    opts = put_in(opts[:label][:span], true)

    draw_form_group(
      draw_label(form, field, opts),
      content
    )
  end

  def radio_buttons(form = %Form{}, field, values, opts \\ []) when is_list(values) do
    values = add_labels_to_values(values)

    {input_opts, opts} = Keyword.pop(opts, :input, [])
    {help, input_opts} = Keyword.pop(input_opts, :help)

    input_id = Form.input_id(form, field)
    help = draw_help(help)
    error = draw_error_message(get_error(form, field))

    inputs =
      values
      |> Enum.with_index()
      |> Enum.map(fn {{label, value}, index} ->
        value = elem(HTML.html_escape(value), 1)

        # error needs to show up only on last element
        radio_error =
          if(Enum.count(values) - 1 == index) do
            error
          else
            ""
          end

        radio_class = "form-check-input " <> is_valid_class(form, field)

        value_id = value |> String.replace(~r/\s/, "")
        input_id = input_id <> "_" <> value_id

        draw_form_check(
          Form.radio_button(form, field, value, class: radio_class),
          label,
          input_id,
          radio_error,
          input_opts[:inline]
        )
      end)

    content =
      Tag.content_tag :div, class: "#{control_col_class(form)}" do
        [inputs, help]
      end

    opts = Keyword.put_new(opts, :label, [])
    opts = put_in(opts[:label][:span], true)

    draw_form_group(
      draw_label(form, field, opts),
      content
    )
  end

  def submit(form = %Form{}, opts) when is_list(opts), do: draw_submit(form, nil, opts)
  def submit(form = %Form{}, label), do: draw_submit(form, label, [])
  def submit(form = %Form{}, label, opts \\ []), do: draw_submit(form, label, opts)
  def submit(form = %Form{}), do: draw_submit(form, nil, [])

  def static(form = %Form{}, label, content) do
    label =
      Tag.content_tag(
        :label,
        label,
        class: "col-form-label #{label_align_class(form)} #{label_col_class(form)}"
      )

    content =
      Tag.content_tag(:div, content, class: "form-control-plaintext #{control_col_class(form)}")

    draw_form_group(label, content)
  end

  # -- Private methods ---------------------------------------------------------
  defp label_col_class(form) do
    default = Application.get_env(:phoenix_bootstrap_form, :label_col_class, @label_col_class)
    Keyword.get(form.options, :label_col, default)
  end

  defp control_col_class(form) do
    default = Application.get_env(:phoenix_bootstrap_form, :control_col_class, @control_col_class)
    Keyword.get(form.options, :control_col, default)
  end

  defp label_align_class(form) do
    default = Application.get_env(:phoenix_bootstrap_form, :label_align_class, @label_align_class)
    Keyword.get(form.options, :label_align, default)
  end

  defp form_group_class() do
    Application.get_env(:phoenix_bootstrap_form, :form_group_class, @form_group_class)
  end

  defp merge_css_classes(opts) do
    {classes, rest} = Keyword.split(opts, [:class])

    class =
      classes
      |> Keyword.values()
      |> Enum.join(" ")

    [class: class] ++ rest
  end

  defp is_valid_class(form, field) do
    case has_error?(form, field) do
      true -> "is-invalid"
      _ -> ""
    end
  end

  defp has_error?(%Form{errors: errors}, field), do: Keyword.has_key?(errors, field)
  defp has_error?(_, _), do: false

  defp get_error(form, field) do
    case has_error?(form, field) do
      true ->
        msg = form.errors[field] |> elem(0)
        opts = form.errors[field] |> elem(1)
        translate_error(msg, opts)

      _ ->
        nil
    end
  end

  defp add_labels_to_values(values) when is_list(values) do
    Enum.into(values, [], fn value ->
      case value do
        {k, v} -> {k, v}
        v -> {Form.humanize(v), v}
      end
    end)
  end

  defp draw_generic_input(type, form, field, options, opts) do
    draw_form_group(
      draw_label(form, field, opts),
      draw_control(type, form, field, options, opts)
    )
  end

  defp draw_control(type, form, field, options, opts) do
    Tag.content_tag :div, class: control_col_class(form) do
      is_valid_class = is_valid_class(form, field)
      input_opts = [class: "form-control #{is_valid_class}"] ++ Keyword.get(opts, :input, [])
      {prepend, input_opts} = Keyword.pop(input_opts, :prepend)
      {append, input_opts} = Keyword.pop(input_opts, :append)
      {help, input_opts} = Keyword.pop(input_opts, :help)

      input =
        draw_input(type, form, field, options, input_opts)
        |> draw_input_group(prepend, append)

      help = draw_help(help)
      error = draw_error_message(get_error(form, field))

      [input, error, help]
    end
  end

  defp draw_input(:select, form, field, options, opts) do
    Form.select(form, field, options, merge_css_classes(opts))
  end

  defp draw_input(type, form, field, nil, opts) do
    apply(Form, type, [form, field, merge_css_classes(opts)])
  end

  defp draw_form_group(label, content) do
    Tag.content_tag :div, class: form_group_class() do
      [label, content]
    end
  end

  defp draw_label(form, field, opts) when is_atom(field) do
    label_opts = Keyword.get(opts, :label, [])
    {text, label_opts} = Keyword.pop(label_opts, :text, Form.humanize(field))

    label_opts =
      [class: "col-form-label #{label_align_class(form)} #{label_col_class(form)}"] ++ label_opts

    label_opts = merge_css_classes(label_opts)

    {is_span, label_opts} = Keyword.pop(label_opts, :span, false)

    if is_span do
      Tag.content_tag(:span, text, label_opts)
    else
      Form.label(form, field, text, label_opts)
    end
  end

  defp draw_input_group(input, nil, nil), do: input

  defp draw_input_group(input, prepend, append) do
    Tag.content_tag :div, class: "input-group" do
      [
        draw_input_group_addon_prepend(prepend),
        input,
        draw_input_group_addon_append(append)
      ]
    end
  end

  defp draw_input_group_addon_prepend(nil), do: ""

  defp draw_input_group_addon_prepend(content) do
    text = Tag.content_tag(:span, content, class: "input-group-text")
    Tag.content_tag(:div, text, class: "input-group-prepend")
  end

  defp draw_input_group_addon_append(nil), do: ""

  defp draw_input_group_addon_append(content) do
    text = Tag.content_tag(:span, content, class: "input-group-text")
    Tag.content_tag(:div, text, class: "input-group-append")
  end

  defp draw_help(nil), do: ""

  defp draw_help(content) do
    Tag.content_tag(:small, content, class: "form-text text-muted")
  end

  defp draw_submit(form = %Form{}, label, opts) do
    {alternative, opts} = Keyword.pop(opts, :alternative, "")
    opts = [class: "btn"] ++ opts

    content =
      Tag.content_tag :div, class: "#{control_col_class(form)} ml-auto" do
        [Form.submit(label || "Submit", merge_css_classes(opts)), alternative]
      end

    draw_form_group("", content)
  end

  defp draw_form_check(input, label, for_attr, error, is_inline) do
    inline_class = if is_inline, do: "form-check-inline", else: ""
    label = Tag.content_tag(:label, label, for: for_attr, class: "form-check-label")

    Tag.content_tag :div, class: "form-check #{inline_class}" do
      [input, label, error]
    end
  end

  defp draw_error_message(nil), do: ""

  defp draw_error_message(message) do
    Tag.content_tag(:div, message, class: "invalid-feedback")
  end

  def default_translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  defp translate_error(msg, opts) do
    {module, function} =
      Application.get_env(
        :phoenix_bootstrap_form,
        :translate_error_function,
        {__MODULE__, :default_translate_error}
      )

    apply(module, function, [{msg, opts}])
  end
end
