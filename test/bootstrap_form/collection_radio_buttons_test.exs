defmodule BootstrapForm.CollectionRadioButtonsTest do
  use ExUnit.Case
  doctest BootstrapForm.CollectionRadioButtons

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.CollectionRadioButtons

  describe "build/3" do
    test "generates a list of radio buttons when the collection is a list of tuples" do
      collection_input =
        CollectionRadioButtons.build(
          :user,
          :active,
          type: :collection_radio_buttons,
          collection: [{true, 'Yes'}, {false, "No"}]
        )

      expected =
        ~s(<div class="form-check">) <>
          ~s(<input class="form-check-input" id="user_active_true" name="user[active]" type="radio" value="true">) <>
          ~s(<label class="form-check-label" for="user_active_true">Yes</label>) <>
        ~s(</div>) <>
        ~s(<div class="form-check">) <>
          ~s(<input class="form-check-input" id="user_active_false" name="user[active]" type="radio" value="false">) <>
          ~s(<label class="form-check-label" for="user_active_false">No</label>) <>
        ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end

    test "generates a list of radio buttons when the collection is a plain list" do
      collection_input =
        CollectionRadioButtons.build(
          :user,
          :colors,
          type: :collection_radio_buttons,
          collection: ['Red','Blue']
        )

      expected =
        ~s(<div class="form-check">) <>
          ~s(<input class="form-check-input" id="user_colors_Red" name="user[colors]" type="radio" value="Red">) <>
          ~s(<label class="form-check-label" for="user_colors_Red">Red</label>) <>
        ~s(</div>) <>
        ~s(<div class="form-check">) <>
          ~s(<input class="form-check-input" id="user_colors_Blue" name="user[colors]" type="radio" value="Blue">) <>
          ~s(<label class="form-check-label" for="user_colors_Blue">Blue</label>) <>
        ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end

    test "supports custom options" do
      collection_input =
        CollectionRadioButtons.build(
          :user,
          :active,
          type: :collection_radio_buttons,
          collection: [{true, 'Yes'}, {false, "No"}],
          class: "radio-class",
          wrapper_html: [class: "wrapper-class"]
        )

      expected =
        ~s(<div class="form-check wrapper-class">) <>
          ~s(<input class="form-check-input radio-class" id="user_active_true" name="user[active]" type="radio" value="true">) <>
          ~s(<label class="form-check-label" for="user_active_true">Yes</label>) <>
        ~s(</div>) <>
        ~s(<div class="form-check wrapper-class">) <>
          ~s(<input class="form-check-input radio-class" id="user_active_false" name="user[active]" type="radio" value="false">) <>
          ~s(<label class="form-check-label" for="user_active_false">No</label>) <>
        ~s(</div>)

      assert collection_input |> Enum.map(&safe_to_string/1) |> Enum.join() == expected
    end
  end
end
