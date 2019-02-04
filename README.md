# Bootstrap Form

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
Phoenix.HTML available for inputs.

## Installation

```elixir
def deps do
  [
    {:bootstrap_form, "~> 0.1.0"}
  ]
end
```
