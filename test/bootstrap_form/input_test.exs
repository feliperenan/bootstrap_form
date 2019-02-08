defmodule BootstrapForm.InputTest do
  use ExUnit.Case
  doctest BootstrapForm.Input

  alias BootstrapForm.Input

  describe "build/4" do
    test "raise error when an unknow type is given" do
      assert_raise RuntimeError, "type: :unknow is not yet implemented", fn ->
        Input.build(:unknow, :user, :name)
      end
    end
  end

  describe "new/4" do
    test "setup the input according to the given options" do
      form = %Phoenix.HTML.Form{}
      field_name = :name
      options = [hint: "Some hint", wrapper_html: [class: "wrapper-class"], class: "input-class"]
      default_classes = [input_class: "default-input-class", wrapper_class: "default-wrapper-class"]

      expected =
        %Input{
          errors: [],
          hint: "Some hint",
          label_text: nil,
          options: [class: "default-input-class input-class"],
          value: nil,
          values: nil,
          wrapper_options: [class: "default-wrapper-class wrapper-class"],
        }

      assert Input.new(form, field_name, options, default_classes) == expected
    end

    test "setup the input with errors when the field has errors" do
      form = %Phoenix.HTML.Form{errors: [name: {"cannot be blank", []}]}
      field_name = :name
      options = [class: "input-class"]
      default_classes = [input_class: "default-input-class", wrapper_class: "default-wrapper-class"]

      expected =
        %Input{
          errors: ["cannot be blank"],
          hint: nil,
          label_text: nil,
          options: [class: "default-input-class is-invalid input-class"],
          value: nil,
          values: nil,
          wrapper_options: [class: "default-wrapper-class"],
        }

      assert Input.new(form, field_name, options, default_classes) == expected
    end

    test "does not setup errors when the form is an atom" do
      form = :user
      field_name = :name
      options = [class: "input-class"]
      default_classes = [input_class: "default-input-class", wrapper_class: "default-wrapper-class"]

      expected =
        %Input{
          errors: [],
          hint: nil,
          label_text: nil,
          options: [class: "default-input-class input-class"],
          value: nil,
          values: nil,
          wrapper_options: [class: "default-wrapper-class"],
        }

      assert Input.new(form, field_name, options, default_classes) == expected
    end
  end
end
