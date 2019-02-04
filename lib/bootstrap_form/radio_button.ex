defmodule BootstrapForm.RadioButton do
  @moduledoc """
  Module responsible for generating a radio button with bootstrap layout.
  """

  @check_input_wrapper_class "form-check"
  @check_input_class "form-check-input"
  @check_label_class "form-check-label"

  import Phoenix.HTML.Form, only: [radio_button: 4, label: 4]

  alias BootstrapForm.{Input, Wrapper}

  @behaviour Input

  @doc """
  Generate a bootstrap radio button according to the given options.

  ## Custom options

  label_text:   The label's text that will be rendered with the checkbox.
  value:        The radio button value.
  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :color, class: "my-custom-class", label_text: "Red")
      # => <div class="form-check">
             <input class="form-check-input my-custom-class" id="user_color_red" name="user[color]" type="radio" value="red">
             <label class="form-check-label" for="user_color">Red</label>
           </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    {label_text, options} = Keyword.pop(options, :label_text)
    {value, options} = Keyword.pop(options, :value)
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])

    wrapper_options = Input.merge_options(wrapper_options, class: @check_input_wrapper_class)
    input_options = Input.merge_options(input_options, class: @check_input_class)

    Wrapper.build_tag(wrapper_options, options) do
      [
        radio_button(form, field_name, value, input_options),
        label(form, field_name, label_text, class: @check_label_class)
      ]
    end
  end
end
