defmodule BootstrapForm.Select do
  @moduledoc false

  import Phoenix.HTML.Form, only: [select: 4, label: 4]

  alias BootstrapForm.{Input, InputBuilder, Wrapper}

  @behaviour InputBuilder

  @label_class "control-label"
  @default_classes [input_class: "form-control", wrapper_class: "form-group"]

  @doc """
  Generate a bootstrap select input according to the given options.

  ## Custom options

  label_text:   The label's text that will be rendered with the checkbox.
  values:       The values that will be used as select options.
  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :number, class: "my-custom-class", label_text: "Select one number", values: 1..3)
      # => <div class="form-group">
            <label class="control-label" for="user_number">Select one number.</label>
            <select class="form-control my-custom-class" id="user_number" name="user[number]">
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
            </select>
          </div>
  """
  @impl true
  def build(form, field_name, options) do
    input = Input.new(form, field_name, options, @default_classes)

    Wrapper.build_tag(input) do
      [
        label(form, field_name, input.label_text, class: @label_class),
        select(form, field_name, input.values, input.options)
      ]
    end
  end
end
