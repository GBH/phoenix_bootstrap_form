defmodule PhoenixBootstrapForm do

  alias Phoenix.HTML.{Tag, Form}

  @label_col    "col-sm-2"
  @control_col  "col-sm-10"
  @label_class  "text-sm-right"

  # Generating wrappers for default form helpers
  [:text_input, :file_input, :email_input, :password_input, :textarea]
    |> Enum.each(fn(method) ->
      def unquote(method)(form = %Form{}, field, opts \\ []) when is_atom(field) do
        draw_generic_input(unquote(method), form, field, opts)
      end
    end)

  # -- Private methods ---------------------------------------------------------

  defp label_col_class(form),   do: Keyword.get(form.options, :label_col, @label_col)
  defp control_col_class(form), do: Keyword.get(form.options, :control_col, @control_col)

  defp state_class(form, field) do
    cond do
      form.errors[field]  -> "has-danger"
      true                -> ""
    end
  end

  defp draw_generic_input(type, form, field, opts) do
    draw_form_group(
      form,
      draw_label(form, field, opts),
      draw_control(type, form, field, opts)
    )
  end

  defp draw_control(type, form, field, opts) do
    Tag.content_tag :div, class: control_col_class(form) do
      input_opts = [class: "form-control"] ++ Keyword.get(opts, :input, [])
      {prepend, input_opts} = Keyword.pop(input_opts, :prepend)
      {append, input_opts}  = Keyword.pop(input_opts, :append)

      input = apply(Form, type, [form, field, merge_css_classes(input_opts)])
        |> draw_input_group(prepend, append)

      help = draw_help(input_opts[:help])

      [input, help]
    end
  end

  defp draw_form_group(form, label, content) do
    Tag.content_tag :div, class: "form-group row" do
      [label, content]
    end
  end

  defp draw_label(form, field, opts) do
    label_opts = Keyword.get(opts, :label, [])
    {text, label_opts} = Keyword.pop(label_opts, :text, Form.humanize(field))

    label_opts = [class: "col-form-label #{@label_class} #{label_col_class(form)}"] ++ label_opts
    Form.label(form, field, text, merge_css_classes(label_opts))
  end

  defp draw_input_group(input, nil, nil), do: input
  defp draw_input_group(input, prepend, append) do
    Tag.content_tag(:div, class: "input-group") do
      [draw_input_group_addon(prepend), input, draw_input_group_addon(append)]
    end
  end

  defp draw_input_group_addon(nil), do: ""
  defp draw_input_group_addon(content) do
    Tag.content_tag(:div, content, class: "input-group-addon")
  end

  defp draw_help(nil), do: ""
  defp draw_help(content) do
    Tag.content_tag(:small, content, class: "form-text text-muted")
  end

  defp merge_css_classes(opts) do
    {classes, rest} = Keyword.split(opts, [:class])
    class = classes
      |> Keyword.values
      |> Enum.join(" ")
    [class: class] ++ rest
  end

end
