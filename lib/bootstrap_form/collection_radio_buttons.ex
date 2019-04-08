defmodule BootstrapForm.CollectionRadioButtons do
  @moduledoc false

  alias BootstrapForm.{Input, RadioButton}

  @behaviour Input

  @doc """
  Generate a list of bootstrap radio buttons according to the given options.

  ## Custom options

  collection: An array of items that will be used to render the radio buttons.

  This function just interprets the given collection to render a radio button for each item. See the
  `RadioButton` module for more info.

  ## Examples

      build(:user, :active, collection: [{true, "Yes"}, {false, "No"}])
      # => <div class="form-check">
             <input class="form-check-input" id="user_active" name="user[active]" type="radio" value="true">
             <label class="form-check-label" for="user_active">Yes</label>
          </div>
          <div class="form-check">
             <input class="form-check-input" id="user_active" name="user[active]" type="radio" value="false">
             <label class="form-check-label" for="user_active">No</label>
          </div>

      build(:user, :colors, collection: ['Red', 'Blue'])
      # => <div class="form-check">
             <input class="form-check-input" id="user_colors" name="user[colors]" type="radio" value="Red">
             <label class="form-check-label" for="user_colors">Red</label>
          </div>
          <div class="form-check">
             <input class="form-check-input" id="user_colors" name="user[colors]" type="radio" value="Blue">
             <label class="form-check-label" for="user_colors">Blue</label>
          </div>
  """
  def build(form, field_name, options \\ []) do
    # Ensure that the type is removed from options since it's going to be added by the RadioButton module.
    {_type, options} = Keyword.pop(options, :type)
    {collection, options} = Keyword.pop(options, :collection)

    for item <- collection do
      options = Keyword.merge(options, build_item_options(item))

      RadioButton.build(form, field_name, options)
    end
  end

  def build_item_options({value, label}), do: [label_text: label, value: value]
  def build_item_options(value), do: [label_text: value, value: value]
end
