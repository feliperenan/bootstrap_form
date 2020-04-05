defmodule BootstrapForm.WrapperTest do
  use ExUnit.Case

  alias BootstrapForm.{Input, Wrapper}

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form, only: [text_input: 2]

  doctest BootstrapForm.Wrapper

  describe "build_tag/3" do
    test "generates the wrapper to the given block" do
      input = %Input{wrapper_options: [class: "my-class"]}

      markup =
        Wrapper.build_tag input do
          text_input(:user, :name)
        end

      expected =
        ~s(<div class="my-class">) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(</div>)

      assert safe_to_string(markup) == expected
    end

    test "generates the wrapper with a hint when this option is given" do
      input = %Input{wrapper_options: [class: "my-class"], hint: "Some hint"}

      markup =
        Wrapper.build_tag input do
          text_input(:user, :name)
        end

      expected =
        ~s(<div class="my-class">) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<small class="text-muted">Some hint</small>) <>
          ~s(</div>)

      assert safe_to_string(markup) == expected
    end

    test "supports custom options" do
      wrapper_options = ["data-field": true, class: "my-class"]
      input = %Input{wrapper_options: wrapper_options, hint: "Some hint"}

      markup =
        Wrapper.build_tag input do
          text_input(:user, :name)
        end

      expected =
        ~s(<div class="my-class" data-field>) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<small class="text-muted">Some hint</small>) <>
          ~s(</div>)

      assert safe_to_string(markup) == expected
    end

    test "generates the wrapper with the error tag when there errors" do
      input = %Input{errors: ["error 1", "error 2"]}

      markup =
        Wrapper.build_tag input do
          text_input(:user, :name)
        end

      expected =
        ~s(<div>) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<div class="invalid-feedback">error 1</div>) <>
          ~s(<div class="invalid-feedback">error 2</div>) <>
          ~s(</div>)

      assert safe_to_string(markup) == expected
    end

    test "generates the wrapper with the error tag and hint when there are both" do
      input = %Input{errors: ["error"], hint: "Some hint"}

      markup =
        Wrapper.build_tag input do
          text_input(:user, :name)
        end

      expected =
        ~s(<div>) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<div class="invalid-feedback">error</div>) <>
          ~s(<small class="text-muted">Some hint</small>) <>
          ~s(</div>)

      assert safe_to_string(markup) == expected
    end
  end
end
