# PhoenixBootstrapForm

Format your application forms with [Bootstrap 4](http://getbootstrap.com) markup.

[![Hex.pm](https://img.shields.io/hexpm/v/phoenix_bootstrap_form.svg?style=flat)](https://hex.pm/packages/phoenix_bootstrap_form)
[![Build Status](https://travis-ci.org/GBH/phoenix_bootstrap_form.svg?style=flat&branch=master)](https://travis-ci.org/GBH/phoenix_bootstrap_form)

## Installation

Add `phoenix_bootstrap_form` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:phoenix_bootstrap_form, "~> 0.1.0"}]
end
```

You may also alias this module in `web.ex` so it's shorter to type in templates.

```elixir
alias PhoenixBootstrapForm, as: PBF
```

## Usage

In order to change markup of form elements to bootstrap-style ones all you need is
to prefix regular methods you aleady have with `PhoenixBootstrapForm`, or `PBF`
if you created an alias. For example:

```elixir
<%= form_for @changeset, "/", fn f -> %>
  <%= PBF.text_input f, :value %>
  <%= PBF.submit f %>
<% end %>
```

Becomes bootstrap-styled:

```html
<form accept-charset="UTF-8" action="/" method="post">
  <div class="form-group row">
    <label class="col-form-label text-sm-right col-sm-2" for="record_value">
      Value
    </label>
    <div class="col-sm-10">
      <input class="form-control" id="record_value" name="record[value]" type="text">
    </div>
  </div>
  <div class="form-group row">
    <div class="col-sm-10 ml-auto">
      <button class="btn" type="submit">Submit</button>
    </div>
  </div>
</form>
```

This library generates [horizonal form](https://getbootstrap.com/docs/4.0/components/forms/#horizontal-form)
layout that collapses down on small screens.

You can always fall-back to default [Phoenix.HTML.Form](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html)
methods if bootstrapped ones are not good enough.

Currently this module supports following methods:

* text_input
* file_input
* email_input
* password_input
* textarea
* telephone_input
* select
* checkbox
* checkboxes
* radio_buttons
* submit
* static

[For quick reference you can look at this template](demo/lib/demo_web/templates/page/index.html.eex).
You can `mix phx.server` inside demo folder to see this reference template rendered.

### Labels

To set your own label you can do something like this:

```elixir
<%= PBF.text_input f, :value, label: [text: "Custom"] %>
```

### CSS Classes

To add your own css class to the input element / controls do this:

```elixir
<%= PBF.text_input f, :value, input: [class: "custom"] %>
```

### Help Text

You can add help text under the input. It could also be rendered template with
links, tables, and whatever else.

```elixir
<%= PBF.text_input f, :value, input: [help: "Help text"] %>
```

### Prepending and Appending Inputs

```elixir
<%= PBF.text_input f, :value, input: [prepend: "$", append: ".00"] %>
```

### Radio Buttons

You don't need to do multiple calls to create list of radio buttons. One method
will do them all:

```elixir
<%= PBF.radio_buttons f, :value, ["red", "green"] %>
```

or with custom labels:

```elixir
<%= PBF.radio_buttons f, :value, [{"R", "red"}, {"G", "green"}] %>

```

or rendered inline:

```elixir
<%= PBF.radio_buttons f, :value, ["red", "green", "blue"], input: [inline: true] %>
```

### Checkboxes

Very similar to `multiple_select` in functionality, you can render collection of
checkboxes. Other options are the same as for `radio_buttons`

```elixir
<%= PBF.checkboxes f, :value, ["red", "green", "blue"], selected: ["green"] %>
```

### Submit Buttons

Besides simple `PBF.submit f` you can define custom label and content that goes
next to the button. For example:

```elixir
<% cancel = link "Cancel", to: "/", class: "btn btn-link" %>
<%= PBF.submit f, "Smash", class: "btn-primary", alternative: cancel %>
```

### Static Elements

When you need to render a piece of content in the context of your form. For example:

```elixir
<%= PBF.static f, "Current Avatar", avatar_image_tag %>
```

### Form Errors

If changeset is invalid, form elements will have `.is-invalid` class added and
`.invalid-feedback` container will be appended with an error message.

In order to properly pull in i18n error messages specify `translate_error`
function that handles it:

```elixir
config :phoenix_bootstrap_form, [
  translate_error_function: {MyApp.ErrorHelpers, :translate_error}
]
```

### Custom Grid and Label Alignment

By default `.col-sm-2` and `.col-sm-10` used for label and control colums respectively.
You can change that by passing `label_col` and `control_col` with `form_for` like this:

```elixir
<% opts = [label_col: "col-sm-4", control_col: "col-sm-8", label_align: "text-sm-left"] %>
<%= form_for @changeset, "/", opts, fn f -> %>

```

If you need to change it application-wide just edit your `config.exs` and add:

```elixir
config :phoenix_bootstrap_form,
  label_col_class:    "col-sm-4",
  control_col_class:  "col-sm-8",
  label_align_class:  "text-sm-left",
  form_group_class:   "form-group myclass"

```

---

Copyright 2017-2018, Oleg Khabarov
