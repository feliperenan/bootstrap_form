defmodule BootstrapForm.Checkbox do
  @moduledoc """
  Module responsible for generating a checkbox input with bootstrap layout.
  """

  import Phoenix.HTML.Form, only: [checkbox: 3, label: 4]

  alias BootstrapForm.{Input, Wrapper}

  @default_classes [input_class: "form-check-input", wrapper_class: "form-check"]

  @behaviour Input

  @doc """
  Generate a bootstrap checkbox input according to the given options.

  ## Custom options

  label_text:   The label's text that will be rendered with the checkbox.
  wrapper_html: HTML attributes for the wrapper.

  ## Examples

      build(:user, :name, class: "my-custom-class", label_text: "Active?")
      # => <div class="form-check">
             <input name="user[active]" type="hidden" value="false">
             <input class="form-check-input my-custom-class" id="user_active" name="user[active]" type="checkbox" value="true">
             <label class="form-check-label" for="user_active">Active?</label>
          </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    input = Input.new(form, field_name, options, @default_classes)

    Wrapper.build_tag(input) do
      [
        checkbox(form, field_name, input.options),
        label(form, field_name, input.label_text, class: "form-check-label")
      ]
    end
  end
end
