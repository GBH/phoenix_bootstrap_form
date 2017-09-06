# PhoenixBootstrapForm [![Hex.pm](https://img.shields.io/hexpm/v/phoenix_bootstrap_form.svg?style=flat)](https://hex.pm/packages/phoenix_bootstrap_form) [![Build Status](https://travis-ci.org/GBH/phoenix_bootstrap_form.svg?style=flat&branch=master)](https://travis-ci.org/GBH/phoenix_bootstrap_form)

Format your application forms with Bootstrap 4 markup.

## Installation

Add `phoenix_bootstrap_form` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:phoenix_bootstrap_form, "~> 0.0.1"}]
end
```

You may also alias this module in `web.ex` so it's shorter to type in templates.

```elixir
alias PhoenixBootstrapForm, as: FBF
```

## Usage

In order to change markup of form elements to bootstrap-style ones all you need is
to prefix regular methods you aleady have with `PhoenixBootstrapForm`, or `FBF`
if you created an alias. For example, this vanilla form:

```elixir
<%= form_for @changeset, "/", fn f -> %>
  <%= text_input f, :value %>
<% end %>
```

Becomes bootstrap-styled:

```elixir
<%= form_for @changeset, "/", fn f -> %>
  <%= FBF.text_input f, :value %>
<% end %>

```

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
* radio_button
* submit

[For quick reference you can look at this template](https://github.com/GBH/phoenix_bootstrap_form/blob/master/dummy/lib/dummy_web/templates/page/index.html.eex). You can `mix phx.server` inside dummy folder to see
this reference template rendered.


### Copyright

(C) 2017 Oleg Khabarov