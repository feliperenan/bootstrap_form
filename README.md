# Bootstrap Form

![Actions Status](https://github.com/feliperenan/bootstrap_form/workflows/Elixir%20CI/badge.svg)

Build Bootstrap Forms easily using Bootstrap Form. With this library, you can build a Bootstrap 
field with one line of code. See:

```Elixir
input :user, :name
```

Generates:

```HTML
<div class="form-group">
  <label class="control-label" for="user_name">Name</label>
  <input class="form-control my-custom-class" id="user_name" name="user[name]" type="text">
</div>
```

Bootstrap Form is built on top of `Phoenix.HTML.Form`, so you have all options provided by 
`Phoenix.HTML` available for inputs.

See the [docs](https://hexdocs.pm/bootstrap_form/BootstrapForm.html) and [this demo app](https://github.com/feliperenan/bootstrap_form_demo) for more info.

## Installation

```elixir
def deps do
  [
    {:bootstrap_form, "~> 0.1.0"}
  ]
end
```
