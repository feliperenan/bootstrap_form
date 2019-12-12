defmodule BootstrapForm.TextInput do
  @moduledoc false

  import Phoenix.HTML.Form, only: [text_input: 3, label: 3]

  alias BootstrapForm.{Input, InputBuilder, Wrapper}

  @label_class "control-label"
  @default_classes [input_class: "form-control", wrapper_class: "form-group"]

  @behaviour InputBuilder

  @doc """
  Generate a bootstrap text input according to the given options.

  ## Custom options

  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :name, class: "my-custom-class")
      # => <div class="form-group">
             <label class="control-label" for="user_name">Name</label>
             <input class="form-control my-custom-class" id="user_name" name="user[name]" type="text">
           </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    input = Input.new(form, field_name, options, @default_classes)

    Wrapper.build_tag(input) do
      [
        label(form, field_name, class: @label_class),
        text_input(form, field_name, input.options)
      ]
    end
  end
end
