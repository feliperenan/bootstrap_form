defmodule BootstrapForm.Input do
  @moduledoc """
  A behaviour to standardize the way that the input building.
  """

  defstruct [
    errors: [],
    hint: nil,
    label_text: nil,
    options: [],
    value: nil,
    values: nil,
    wrapper_options: []
  ]

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

  def new(_form, _field_name, options, default_classes) do
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])
    {hint, input_options} = Keyword.pop(input_options, :hint)
    {label_text, input_options} = Keyword.pop(input_options, :label_text)
    {value, input_options} = Keyword.pop(input_options, :value)
    {values, input_options} = Keyword.pop(input_options, :values)

    wrapper_default_class = Keyword.get(default_classes, :wrapper_class)
    input_default_class = Keyword.get(default_classes, :input_class)

    wrapper_options = merge_options(wrapper_options, class: wrapper_default_class)
    input_options = merge_options(input_options, class: input_default_class)

    %__MODULE__{
      hint: hint,
      label_text: label_text,
      options: input_options,
      value: value,
      values: values,
      wrapper_options: wrapper_options,
    }
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