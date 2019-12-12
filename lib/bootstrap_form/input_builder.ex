defmodule BootstrapForm.InputBuilder do
  @moduledoc false

  @callback build(Form.t() | atom, atom, Keyword.t()) :: term

  @implementation_types %{
    checkbox: BootstrapForm.Checkbox,
    email_input: BootstrapForm.EmailInput,
    password_input: BootstrapForm.PasswordInput,
    radio_button: BootstrapForm.RadioButton,
    select: BootstrapForm.Select,
    textarea: BootstrapForm.Textarea,
    text_input: BootstrapForm.TextInput,
    collection_checkboxes: BootstrapForm.CollectionCheckboxes,
    collection_radio_buttons: BootstrapForm.CollectionRadioButtons,
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
end
