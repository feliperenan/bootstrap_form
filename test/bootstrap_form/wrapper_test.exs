defmodule BootstrapForm.WrapperTest do
  use ExUnit.Case
  doctest BootstrapForm.Wrapper

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form, only: [text_input: 2]

  alias BootstrapForm.Wrapper

  describe "build_tag/3" do
    test "generates the wrapper to the given block" do
      expected =
        ~s(<div class="my-class">) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
        ~s(</div>)

      markup =
        Wrapper.build_tag([class: "my-class"], [class: "child-class"]) do
          text_input(:user, :name)
        end

      assert safe_to_string(markup) == expected
    end

    test "generates the wrapper with a hink when this option is given" do
      expected =
        ~s(<div class="my-class">) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<small class="text-muted">Some hint</small>) <>
        ~s(</div>)

      markup =
        Wrapper.build_tag([class: "my-class"], [class: "child-class", hint: "Some hint"]) do
          text_input(:user, :name)
        end

      assert safe_to_string(markup) == expected
    end

    test "supports custom options" do
      expected =
        ~s(<div class="my-class" data-field>) <>
          ~s(<input id="user_name" name="user[name]" type="text">) <>
          ~s(<small class="text-muted">Some hint</small>) <>
        ~s(</div>)

      wrapper_options = ["data-field": true, class: "my-class"]
      input_options = [class: "child-class", hint: "Some hint"]

      markup =
        Wrapper.build_tag(wrapper_options, input_options) do
          text_input(:user, :name)
        end

      assert safe_to_string(markup) == expected
    end
  end
end
