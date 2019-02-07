defmodule BootstrapForm.EmailInput do
  @moduledoc """
  Module responsible for generating a email input with bootstrap layout.
  """

  import Phoenix.HTML.Form, only: [email_input: 3, label: 3]

  alias BootstrapForm.{Input, Wrapper}

  @label_class "control-label"
  @default_classes [input_class: "form-control", wrapper_class: "form-group"]

  @behaviour Input

  @doc """
  Generate a bootstrap text input according to the given options.

  ## Custom options

  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :email, class: "my-custom-class")
      # => <div class="form-group">
             <label class="control-label" for="user_email">Email</label>
             <input class="form-control my-custom-class" id="user_email" name="user[email]" type="text">
           </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    input = Input.new(form, field_name, options, @default_classes)

    Wrapper.build_tag(input) do
      [
        label(form, field_name, class: @label_class),
        email_input(form, field_name, input.options)
      ]
    end
  end
end
