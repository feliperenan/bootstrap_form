defmodule BootstrapForm.EmailInputTest do
  use ExUnit.Case
  doctest BootstrapForm.EmailInput

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias BootstrapForm.EmailInput

  describe "build/3" do
    test "generates an email input" do
      expected =
        ~s(<div class="form-group wrapper-class">) <>
          ~s(<label class="control-label" for="user_email">Email</label>) <>
          ~s(<input class="form-control" id="user_email" name="user[email]" type="email">) <>
        ~s(</div>)

      input = EmailInput.build(:user, :email, wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "support custom options" do
      expected =
        ~s(<input class="form-control my-class" id="user_email" name="user[email]" type="email">)

       input = EmailInput.build(:user, :email, class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
