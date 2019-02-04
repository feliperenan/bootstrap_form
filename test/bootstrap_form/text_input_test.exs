defmodule BootstrapForm.TextInputTest do
  use ExUnit.Case
  doctest BootstrapForm.TextInput

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.TextInput

  describe "build/3" do
    test "generates an text input" do
      expected =
        ~s(<div class="form-group wrapper-class">) <>
          ~s(<label class="control-label" for="user_name">Name</label>) <>
          ~s(<input class="form-control" id="user_name" name="user[name]" type="text">) <>
        ~s(</div>)

      input = TextInput.build(:user, :name, wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "support custom options" do
      expected =
        ~s(<input class="form-control my-class" id="user_name" name="user[name]" placeholder="Inform your full name." type="text">)

       input = TextInput.build(:user, :name, class: "my-class", placeholder: "Inform your full name.")

      assert safe_to_string(input) =~ expected
    end
  end
end
