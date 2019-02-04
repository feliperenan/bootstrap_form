defmodule BootstrapForm.Checkbox do
  @moduledoc """
  Module responsible for generating a checkbox input with bootstrap layout.
  """

  @check_input_wrapper_class "form-check"
  @check_input_class "form-check-input"

  import Phoenix.HTML.Form, only: [checkbox: 3, label: 4]

  alias BootstrapForm.{Input, Wrapper}

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
    {label_text, options} = Keyword.pop(options, :label_text)
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])

    wrapper_options = Input.merge_options(wrapper_options, class: @check_input_wrapper_class)
    input_options = Input.merge_options(input_options, class: @check_input_class)

    Wrapper.build_tag(wrapper_options, options) do
      [
        checkbox(form, field_name, input_options),
        label(form, field_name, label_text, class: "form-check-label")
      ]
    end
  end
end
