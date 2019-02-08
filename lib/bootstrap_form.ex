defmodule BootstrapForm do
  @moduledoc """
  Helpers related to producing inputs using Bootstrap classes.

  As `BootstrapForm` is built on top of `Phoenix.HTML.Form`, we use as many resources from
  `Phoenix.Html.Form` as possible. Then, when you don't provide a type attribute the
  `input/3` is going to guess the type using `Phoenix.HTML.Form.input_type/2`.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input form, :name %>
          <%= input form, :password %>
          <%= input form, :email %>

          <%= submit "Submit", class: "btn btn-primary" %>
        <% end %>

  If you want other types such as: select, radio button, checkbox, etc... you must provide the
  properly type to `input/3`.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input(form, :active, type: :checkbox, label_text: "Active?") %>
          <%= input(form, :number, type: :select, label_text: "Select one number", values: 1..3) %>
          <%= submit "Submit" %>
        <% end %>

  ## Custom options

  Some inputs need other options besides the ones supported by `Phoenix.HTML`, as follow:

    * `:label_text` - To change the label text thatl will be rendered with the input. Required for
        checkbox, radio button and select.

    * `:values` - The options that will be rendered by the select input. This option is only for
       select input.

    * `:wrapper_html` - The HTML attributes to the wrapper tag.
  """

  @doc false
  def input(form, field_name, options \\ []) do
    {type, options} = Keyword.pop(options, :type)

    type = type || Phoenix.HTML.Form.input_type(form, field_name)

    BootstrapForm.Input.build(type, form, field_name, options)
  end
end
