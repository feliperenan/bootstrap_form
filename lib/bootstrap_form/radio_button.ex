defmodule BootstrapForm.RadioButton do
  @moduledoc false

  import Phoenix.HTML.Form, only: [radio_button: 4, label: 4, input_id: 3]

  alias BootstrapForm.{Input, InputBuilder, Wrapper}

  @default_classes [input_class: "form-check-input", wrapper_class: "form-check"]

  @behaviour InputBuilder

  @doc """
  Generate a bootstrap radio button according to the given options.

  ## Custom options

  label_text:   The label's text that will be rendered with the checkbox.
  value:        The radio button value.
  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :color, class: "my-custom-class", label_text: "Red", value: "red")
      # => <div class="form-check">
             <input class="form-check-input my-custom-class" id="user_color_red" name="user[color]" type="radio" value="red">
             <label class="form-check-label" for="user_color">Red</label>
           </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    input = Input.new(form, field_name, options, @default_classes)
    label_for = input_id(form, field_name, input.value)

    Wrapper.build_tag(input) do
      [
        radio_button(form, field_name, input.value, input.options),
        label(form, field_name, input.label_text, class: "form-check-label", for: label_for)
      ]
    end
  end
end
