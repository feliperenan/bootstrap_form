defmodule BootstrapForm.Input do
  @moduledoc """
  A behaviour to standardize the way that the input building.
  """

  alias BootstrapForm.{
    Checkbox,
    EmailInput,
    PasswordInput,
    RadioButton,
    Select,
    Textarea,
    TextInput
  }

  @callback build(Form.t() | atom, atom, Keyword.t()) :: term

  @implementation_types %{
    checkbox: Checkbox,
    email_input: EmailInput,
    password_input: PasswordInput,
    radio_button: RadioButton,
    select: Select,
    textarea: Textarea,
    text_input: TextInput
  }

  @doc """
  Build an input according to the given type.

  This function delegates the build for some module listed in @implementation_types. Case an unknow
  type is given, an error is going to be raised.
  """
  def build(type, form, field_name, options \\ []) do
    case @implementation_types[type] do
      nil -> raise "type: :#{type} is not yet implemented"
      implementation -> implementation.build(form, field_name, options)
    end
  end

  @doc """
  Merge default options with the given custom options.

  This merge is going to concatenate css classes if there are classes in both options.

  ## Examples

     iex> BootstrapForm.Input.merge_options([class: "form-control"], [placeholder: "Username"])
     [class: "form-control", placeholder: "Username"]

     iex> BootstrapForm.Input.merge_options([class: "form-control"], [class: "my-class"])
     [class: "my-class form-control"]

  """
  def merge_options(default_options, custom_options) do
    Keyword.merge(default_options, custom_options, &merge_options/3)
  end

  defp merge_options(:class, custom_class, default_class) do
    class = default_class <> " " <> custom_class

    String.trim(class)
  end
end
