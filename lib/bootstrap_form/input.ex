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

  @doc """
  Setup a `BootstrapForm.Input` according to the given options.

  This function breaks the given options down to proper render it. Let's say we got the following input:

      <%= input form, :name, wrapper_html: [class: "wrapper-class"], hint: "Inform your full name" %>

  As input options, wrapper options and hint are within the given options, they will be splitted up in order to
  map the proper HTML attributes for each tag that will be generated. Besides that, errors and default classes
  will be set.

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
