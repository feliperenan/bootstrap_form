defmodule BootstrapForm.SelectTest do
  use ExUnit.Case
  doctest BootstrapForm.Select

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.Select

  describe "build/3" do
    test "generates a select input" do
      expected =
        ~s(<div class="form-group wrapper-class">) <>
          ~s(<label class="control-label" for="user_number">Select one number.</label>) <>
          ~s(<select class="form-control" id="user_number" name="user[number]">) <>
            ~s(<option value="1">1</option>) <>
            ~s(<option value="2">2</option>) <>
            ~s(<option value="3">3</option>) <>
          ~s(</select>) <>
        ~s(</div>)

      input = Select.build(:user, :number, values: 1..3, label_text: "Select one number.", wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "select supports custom options" do
      expected = ~s(<select class="form-control my-class" id="user_number" name="user[number]">)

      input = Select.build(:user, :number, values: 1..3, label_text: "Select one number.", class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
