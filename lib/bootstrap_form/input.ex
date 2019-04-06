defmodule BootstrapForm.Input do
  @moduledoc false

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
    CollectionCheckboxes,
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
    text_input: TextInput,
    collection_checkboxes: CollectionCheckboxes
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
  Setup a `BootstrapForm.Input` according to the given options.

  Every time that we need to build an input we need to configure its options and break these options
  down to properly render it. Then imagine the following input:

    <%= form_for @changeset, "/", fn form -> %>
      <%= input form, :name, wrapper_html: [class: "wrapper-class"], hint: "Inform your full name" %>
    <% end %>

  As the input options, wrapper options and hint are within options, we need to split these options
  in order to map the proper HTML attributes for each tag. Besides that, we need to set errors when
  the field has them and set the default Bootstrap classes to the wrapper and the input.

  This function is supposed to be used before an input is built.
  """
  def new(form, field_name, options, default_classes) do
    {wrapper_options, input_options} = Keyword.pop(options, :wrapper_html, [])
    {hint, input_options} = Keyword.pop(input_options, :hint)
    {label_text, input_options} = Keyword.pop(input_options, :label_text)
    {value, input_options} = Keyword.pop(input_options, :value)
    {values, input_options} = Keyword.pop(input_options, :values)

    errors = get_errors(form, field_name)

    wrapper_default_class = Keyword.get(default_classes, :wrapper_class)
    input_default_class = Keyword.get(default_classes, :input_class)

    wrapper_options = merge_options(wrapper_options, class: wrapper_default_class)

    input_options =
      if Enum.empty?(errors) do
        merge_options(input_options, class: input_default_class)
      else
        merge_options(input_options, class: "#{input_default_class} is-invalid")
      end

    %__MODULE__{
      errors: errors,
      hint: hint,
      label_text: label_text,
      options: input_options,
      value: value,
      values: values,
      wrapper_options: wrapper_options,
    }
  end

  defp get_errors(form, _field_name) when is_atom(form), do: []

  defp get_errors(form, field_name) do
    form.errors
    |> Keyword.get_values(field_name)
    |> Enum.map(fn {error, _opts} -> error end)
  end

  # Merge default options with the given custom options.
  #
  # This merge is going to concatenate css classes if there are classes in both options.
  #
  # ## Examples
  #
  #    merge_options([class: "form-control"], [placeholder: "Username"])
  #    #=> [class: "form-control", placeholder: "Username"]
  #
  #    merge_options([class: "form-control"], [class: "my-class"])
  #    #=> [class: "my-class form-control"]
  #
  defp merge_options(default_options, custom_options) do
    Keyword.merge(default_options, custom_options, &merge_options/3)
  end

  defp merge_options(:class, custom_class, default_class) do
    class = default_class <> " " <> custom_class

    String.trim(class)
  end
end
