defmodule BootstrapForm.TextInputTest do
  use ExUnit.Case

  alias BootstrapForm.TextInput

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form, only: [form_for: 4]

  doctest TextInput

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

      input =
        TextInput.build(:user, :name, class: "my-class", placeholder: "Inform your full name.")

      assert safe_to_string(input) =~ expected
    end

    test "add the error class when the field has error" do
      errors = [name: {"cannot be blank", []}]

      conn = Plug.Test.conn(:get, "/foo", %{})

      form =
        form_for(conn, "/", [as: :user, errors: errors], fn form ->
          TextInput.build(form, :name)
        end)

      expected =
        ~s(<input class="form-control is-invalid" id="user_name" name="user[name]" type="text">)

      assert safe_to_string(form) =~ expected
    end
  end
end
