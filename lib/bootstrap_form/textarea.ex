defmodule BootstrapForm.Textarea do
  @moduledoc """
  Module responsible for generating a textarea with bootstrap layout.
  """

  @input_wrapper_class "form-group"
  @label_class "control-label"
  @input_class "form-control"

  import Phoenix.HTML.Form, only: [label: 3, textarea: 3]

  alias BootstrapForm.{Input, Wrapper}

  @behaviour BootstrapForm.Input

  @doc """
  Generate a bootstrap textarea input according to the given options.

  ## Custom options

  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :bio, class: "my-custom-class")
      # => <div class="form-group">
             <label class="control-label" for="user_bio">Bio</label>
             <textarea class="form-control my-custom-class" id="user_bio" name="user[bio]">\n</textarea>
           </div>
  """
  def build(form, field_name, options \\ []) do
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])

    wrapper_options = Input.merge_options(wrapper_options, class: @input_wrapper_class)
    input_options = Input.merge_options(input_options, class: @input_class)

    Wrapper.build_tag(wrapper_options, input_options) do
      [
        label(form, field_name, class: @label_class),
        textarea(form, field_name, input_options)
      ]
    end
  end
end
