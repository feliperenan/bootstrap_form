defmodule BootstrapForm.Textarea do
  @moduledoc """
  Module responsible for generating a textarea with bootstrap layout.
  """

  import Phoenix.HTML.Form, only: [label: 3, textarea: 3]

  alias BootstrapForm.{Input, Wrapper}

  @label_class "control-label"
  @default_classes [input_class: "form-control", wrapper_class: "form-group"]

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
    input = Input.new(form, field_name, options, @default_classes)

    Wrapper.build_tag(input) do
      [
        label(form, field_name, class: @label_class),
        textarea(form, field_name, input.options)
      ]
    end
  end
end
