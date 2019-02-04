defmodule BootstrapForm.PasswordInput do
  @moduledoc """
  Module responsible for generating a password input with bootstrap layout.
  """

  @input_wrapper_class "form-group"
  @label_class "control-label"
  @input_class "form-control"

  import Phoenix.HTML.Form, only: [password_input: 3, label: 3]

  alias BootstrapForm.{Input, Wrapper}

  @behaviour Input

  @doc """
  Generate a bootstrap password input according to the given options.

  ## Custom options

  wrapper_html: HTML attributes that will be used in the wrapper.

  ## Examples

      build(:user, :password, class: "my-custom-class")
      # => <div class="form-group">
             <label class="control-label" for="user_password">Password</label>
             <input class="form-control my-custom-class" id="user_password" name="user[password]" type="text">
           </div>
  """
  @impl true
  def build(form, field_name, options \\ []) do
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])

    wrapper_options = Input.merge_options(wrapper_options, class: @input_wrapper_class)
    input_options = Input.merge_options(input_options, class: @input_class)

    Wrapper.build_tag(wrapper_options, input_options) do
      [
        label(form, field_name, class: @label_class),
        password_input(form, field_name, input_options)
      ]
    end
  end
end
