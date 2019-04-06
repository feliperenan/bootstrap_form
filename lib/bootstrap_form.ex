defmodule BootstrapForm do
  @moduledoc """
  Helpers related to producing inputs using Bootstrap classes.

  As `BootstrapForm` is built on top of `Phoenix.HTML.Form`, we use as many resources from
  `Phoenix.HTML.Form` as possible. Then, when you don't provide a type attribute the
  `input/3` is going to guess the type using `Phoenix.HTML.Form.input_type/2`.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input form, :name %>
          <%= input form, :password %>
          <%= input form, :email %>
          <%= submit "Submit", class: "btn btn-primary" %>
        <% end %>

  If you want other types such as: select, radio button, checkbox and textarea you must provide the
  properly type to `input/3`.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input(:user, :bio, type: :textarea)
          <%= input(form, :active, type: :checkbox, label_text: "Active?") %>
          <%= input(form, :color, type: :radio_button, label_text: "Red", value: "red")
          <%= input(form, :number, type: :select, label_text: "Select one number", values: 1..3) %>
          <%= submit "Submit", classL "btn btn-primary" %>
        <% end %>

  It also supports a collection of checkboxes.

        <%= input(form, :active, type: :collection_checkboxes, collection: [{true, "Yes"}, {false, "No"}]) %>
        <%= input(form, :colors, type: :collection_checkboxes, collection: ['Red', 'Blue']) %>

  See `input/3` for the available options.
  """

  @doc """
  Builds the input given its name and options.

  As this function uses `Phoenix.HTML.Form` under the hood, the given `form` can be an atom or a
  `%Phoenix.HTML.Form{}` struct. The options are all options available in `Phoenix.HTML` plus
  some custom options, see custom options section below.

  ## Custom options

  Some inputs need other options besides the ones supported by `Phoenix.HTML`, as follow:

    * `:hint` - An string to render whithin the wrapper. This is optional for all inputs.

    * `:label_text` - To change the label text that will be rendered with the input. Required for
        checkbox, radio button and select.

    * `:value` - The value used by the radio button. Required only for radio buttons.

    * `:values` - The options that will be rendered by the select input. Required only for select
       input.

    * `:wrapper_html` - The HTML attributes to the wrapper tag.

    * `:collection` - A list of items to generate multiple checkboxes or radio buttons. Required only
       for collection_checkboxes and collection_radiobuttons.

  """
  def input(form, field_name, options \\ []) do
    {type, options} = Keyword.pop(options, :type)

    type = type || Phoenix.HTML.Form.input_type(form, field_name)

    BootstrapForm.Input.build(type, form, field_name, options)
  end
end
