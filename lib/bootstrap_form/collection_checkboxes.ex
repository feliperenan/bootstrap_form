defmodule BootstrapForm.CollectionCheckboxes do
  @moduledoc false

  alias BootstrapForm.{Input, Checkbox}

  @behaviour Input

  @doc """
  Generate a list of bootstrap checkbox input according to the given options.

  ## Custom options

  collection: An array of items that will be used to render the checkboxes.

  This function just interprets the given collection to render a checkbox for each item. See the
  `Checkbox` module for more info.

  ## Examples

      build(:user, :active, collection: [{true, "Yes"}, {false, "No"}])
      # => <div class="form-check">
             <input name="user[active]" type="hidden" value="false">
             <input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="true">
             <label class="form-check-label" for="user_active">Yes</label>
          </div>
          <div class="form-check">
             <input name="user[active]" type="hidden" value="false">
             <input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="false">
             <label class="form-check-label" for="user_active">No</label>
          </div>

      build(:user, :colors, collection: ['Red', 'Blue'])
      # => <div class="form-check">
             <input name="user[colors]" type="hidden" value="false">
             <input class="form-check-input" id="user_colors" name="user[colors]" type="checkbox" value="Red">
             <label class="form-check-label" for="user_colors">Red</label>
          </div>
          <div class="form-check">
             <input name="user[colors]" type="hidden" value="false">
             <input class="form-check-input" id="user_colors" name="user[colors]" type="checkbox" value="Blue">
             <label class="form-check-label" for="user_colors">Blue</label>
          </div>
  """
  def build(form, field_name, options \\ []) do
    # Ensure that the type is removed from options since it's going to be added by the Checkbox module.
    {_type, options} = Keyword.pop(options, :type)
    {collection, options} = Keyword.pop(options, :collection)

    for item <- collection do
      options = Keyword.merge(options, build_item_options(item))

      Checkbox.build(form, field_name, options)
    end
  end

  def build_item_options({value, label}), do: [label_text: label, value: value, checked_value: value]
  def build_item_options(value), do: [label_text: value, value: value, checked_value: value]
end
