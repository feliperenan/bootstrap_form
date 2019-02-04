defmodule BootstrapForm.RadioButtonTest do
  use ExUnit.Case
  doctest BootstrapForm.RadioButton

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.RadioButton

  describe "build/3" do
    test "generates a radio button" do
      expected =
        ~s(<div class="form-check wrapper-class">) <>
          ~s(<input class="form-check-input" id="user_color_red" name="user[color]" type="radio" value="red">) <>
          ~s(<label class="form-check-label" for="user_color">Red</label>) <>
        ~s(</div>)

      input = RadioButton.build(:user, :color, value: "red", label_text: "Red", wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) =~ expected
    end

    test "radio button supports custom options" do
      expected =
          ~s(<input class="form-check-input my-class" id="user_color_red" name="user[color]" type="radio" value="red">)

      input = RadioButton.build(:user, :color, value: "red", label_text: "Red", class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
