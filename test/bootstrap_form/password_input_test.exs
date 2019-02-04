defmodule BootstrapForm.PasswordInputTest do
  use ExUnit.Case
  doctest BootstrapForm.PasswordInput

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.PasswordInput

  describe "build/3" do
    test "generates an password input" do
      expected =
        ~s(<div class="form-group wrapper-class">) <>
          ~s(<label class="control-label" for="user_password">Password</label>) <>
          ~s(<input class="form-control" id="user_password" name="user[password]" type="password">) <>
        ~s(</div>)

      input = PasswordInput.build(:user, :password, wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "support custom options" do
      expected =
        ~s(<input class="form-control my-class" id="user_password" name="user[password]" type="password">)

       input = PasswordInput.build(:user, :password, class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
