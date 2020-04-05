defmodule BootstrapForm do
  @moduledoc """
  **BootstrapForm** is a library to help you to build Bootstrap 4 forms for Phoenix applications.

  The following code will produce all necessary markup and classes for Bootstrap 4. Make sure that Bootstrap assets are
  available in our application.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input form, :name %>
          <%= input form, :password %>
          <%= input form, :email %>
          <%= submit "Submit", class: "btn btn-primary" %>
        <% end %>


  **BootstrapForm** is built on top of `Phoenix.HTML.Form`. So, if a type is not given, `input/3` is going to guess the
  type using `Phoenix.HTML.Form.input_type/2`. If you want other types such as: select, radio button, checkbox, and
  textarea you must provide the proper type to `input/3`.

        <%= form_for @changeset, Routes.user_path(@conn, :create), fn form -> %>
          <%= input :user, :bio, type: :textarea
          <%= input form, :active, type: :checkbox, label_text: "Active?" %>
          <%= input form, :color, type: :radio_button, label_text: "Red", value: "red"
          <%= input form, :number, type: :select, label_text: "Select one number", values: 1..3 %>
          <%= submit "Submit", class: "btn btn-primary" %>
        <% end %>

  It also supports a collection of checkboxes and/or radio buttons.

        <%= input form, :active, type: :collection_checkboxes, collection: [{true, "Yes"}, {false, "No"}] %>
        <%= input form, :colors, type: :collection_checkboxes, collection: ['Red', 'Blue']) %>

        <%= input form, :active, type: :collection_radio_buttons, collection: [{true, "Yes"}, {false, "No"}] %>
        <%= input form, :colors, type: :collection_radio_buttons, collection: ['Red', 'Blue'] %>

  If you want `input/3` available in your templates, import it your `app_web.ex`:

        def view do
          quote do
            # ...
            import BootstrapForm, only: [input: 3]
          end
        end

  Or call `BootstrapForm.input/3` directly instead.
  """

  @type form :: Phoenix.HTML.Form.t() | atom
  @type field :: atom() | String.t
  @type safe_html :: Phoenix.HTML.safe | list(Phoenix.HTML.safe)


  @doc """
  Build a bootstrap input.

  This function uses `Phoenix.HTML.Form` under the hood, so the given form can be an atom or a `%Phoenix.HTML.Form{}`.
  It takes all options available in `Phoenix.HTML` plus options listed below.

  ## Custom options

    * `:hint` - An string to render within the wrapper. This is optional for all inputs.

    * `:label_text` - To change the label text that will be rendered with the input. Required for checkboxes, radio
       buttons and selects.

    * `:value` - The value used for radio buttons. Required only for radio buttons.

    * `:values` - Options that will be rendered for selects. Required only for selects.

    * `:wrapper_html` - HTML attributes for wrapper tag.

    * `:collection` - A list of items to generate multiple checkboxes or radio buttons. Required only for
       `collection_checkboxes` and `collection_radio_buttons`.

  """
  @spec input(form, field, Keyword.t) :: safe_html
  def input(form, field_name, options \\ []) do
    {type, options} = Keyword.pop(options, :type)

    type = type || Phoenix.HTML.Form.input_type(form, field_name)

    BootstrapForm.InputBuilder.build(type, form, field_name, options)
  end
end
