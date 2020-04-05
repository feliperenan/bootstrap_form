defmodule BootstrapFormTest do
  use ExUnit.Case

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Form, only: [form_for: 4]

  doctest BootstrapForm

  describe "input/3" do
    test "generates an input with bootstrap markup" do
      expected =
        ~s(<div class="form-group">) <>
          ~s(<label class="control-label" for="user_name">Name</label>) <>
          ~s(<input class="form-control" id="user_name" name="user[name]" type="text">) <>
          ~s(</div>)

      form =
        form_for(conn(), "/", [as: :user], fn form ->
          BootstrapForm.input(form, :name)
        end)

      assert safe_to_string(form) =~ expected
    end

    test "generates an input given a type" do
      expected =
        ~s(<div class="form-check">) <>
          ~s(<input name="user[active]" type="hidden" value="false">) <>
          ~s(<input class="form-check-input" id="user_active" name="user[active]" type="checkbox" value="true">) <>
          ~s(<label class="form-check-label" for="user_active">Active?</label>) <>
          ~s(</div>)

      form =
        form_for(conn(), "/", [as: :user], fn form ->
          BootstrapForm.input(form, :active, type: :checkbox, label_text: "Active?")
        end)

      assert safe_to_string(form) =~ expected
    end

    test "raises an error if a unknow type is given" do
      assert_raise RuntimeError, "type: :unknow is not yet implemented", fn ->
        form_for(conn(), "/", [as: :user], fn form ->
          BootstrapForm.input(form, :name, type: :unknow)
        end)
      end
    end
  end

  defp conn do
    Plug.Test.conn(:get, "/foo", %{})
  end
end
