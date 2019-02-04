defmodule BootstrapForm.CheckboxTest do
  use ExUnit.Case
  doctest BootstrapForm.Checkbox

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.Checkbox

  describe "build/3" do
    test "generates a checkbox" do
      expected =
        ~s(<div class="form-check wrapper-class">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="true">) <>
          ~s(<label class="form-check-label" for="user_active">Active?</label>) <>
        ~s(</div>)

      input = Checkbox.build(:user, :active, type: :checkbox, label_text: "Active?", wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "checkbox supports custom options" do
      expected =
          ~s(<input class="form-check-input my-class" id="user_active" name="user[active]" type="checkbox" value="true">)

      input = Checkbox.build(:user, :active, type: :checkbox, label_text: "Active?", class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
