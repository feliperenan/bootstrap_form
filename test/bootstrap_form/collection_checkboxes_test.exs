defmodule BootstrapForm.CollectionCheckboxesTest do
  use ExUnit.Case

  alias BootstrapForm.CollectionCheckboxes

  import Phoenix.HTML, only: [safe_to_string: 1]

  doctest CollectionCheckboxes

  describe "build/3" do
    test "generates a list of checkbox when the collection is a list of tuples" do
      collection_input =
        CollectionCheckboxes.build(
          :user,
          :active,
          type: :collection_checkboxes,
          collection: [{true, 'Yes'}, {false, "No"}]
        )

      expected =
        ~s(<div class="form-check">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="true">) <>
          ~s(<label class="form-check-label" for="user_active">Yes</label>) <>
          ~s(</div>) <>
          ~s(<div class="form-check">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="false">) <>
          ~s(<label class="form-check-label" for="user_active">No</label>) <>
          ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end

    test "generates a list of checkbox when the collection is a plain list" do
      collection_input =
        CollectionCheckboxes.build(
          :user,
          :colors,
          type: :collection_checkboxes,
          collection: ['Red', 'Blue']
        )

      expected =
        ~s(<div class="form-check">) <>
          ~s(<input name="user[colors]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_colors" name="user[colors]" type="checkbox" value="Red">) <>
          ~s(<label class="form-check-label" for="user_colors">Red</label>) <>
          ~s(</div>) <>
          ~s(<div class="form-check">) <>
          ~s(<input name="user[colors]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_colors" name="user[colors]" type="checkbox" value="Blue">) <>
          ~s(<label class="form-check-label" for="user_colors">Blue</label>) <>
          ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end

    test "supports custom options" do
      collection_input =
        CollectionCheckboxes.build(
          :user,
          :active,
          type: :collection_checkboxes,
          collection: [{true, 'Yes'}, {false, "No"}],
          class: "checkbox-class",
          wrapper_html: [class: "wrapper-class"]
        )

      expected =
        ~s(<div class="form-check wrapper-class">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input checkbox-class" id="user_active" name="user[active]" type="checkbox" value="true">) <>
          ~s(<label class="form-check-label" for="user_active">Yes</label>) <>
          ~s(</div>) <>
          ~s(<div class="form-check wrapper-class">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input checkbox-class" id="user_active" name="user[active]" type="checkbox" value="false">) <>
          ~s(<label class="form-check-label" for="user_active">No</label>) <>
          ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end
  end
end
