defmodule BootstrapForm.TextareaTest do
  use ExUnit.Case

  alias BootstrapForm.Textarea

  import Phoenix.HTML, only: [safe_to_string: 1]

  doctest Textarea

  describe "build/3" do
    test "generates an textarea input" do
      expected =
        ~s(<div class="form-group wrapper-class">) <>
          ~s(<label class="control-label" for="user_bio">Bio</label>) <>
          ~s(<textarea class="form-control" id="user_bio" name="user[bio]">\n</textarea>) <>
          ~s(</div>)

      input = Textarea.build(:user, :bio, wrapper_html: [class: "wrapper-class"])

      assert safe_to_string(input) == expected
    end

    test "textarea supports custom options" do
      expected =
        ~s(<textarea class="form-control my-class" id="user_bio" name="user[bio]">\n</textarea>)

      input = Textarea.build(:user, :bio, class: "my-class")

      assert safe_to_string(input) =~ expected
    end
  end
end
