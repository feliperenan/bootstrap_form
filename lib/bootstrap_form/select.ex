defmodule BootstrapForm.Select do
  @moduledoc """
  Module responsible for generating a select input with bootstrap layout.
  """

  @input_wrapper_class "form-group"
  @label_class "control-label"
  @input_class "form-control"

  import Phoenix.HTML.Form, only: [select: 4, label: 4]

  alias BootstrapForm.{Input, Wrapper}

  @behaviour Input

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
    {label_text, options} = Keyword.pop(options, :label_text)
    {values, options} = Keyword.pop(options, :values)
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])

    wrapper_options = Input.merge_options(wrapper_options, class: @input_wrapper_class)
    input_options = Input.merge_options(input_options, class: @input_class)

    Wrapper.build_tag(wrapper_options, options) do
      [
        label(form, field_name, label_text, class: @label_class),
        select(form, field_name, values, input_options)
      ]
    end
  end
end
