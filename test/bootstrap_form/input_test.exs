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

  describe "merge_options/2" do
    test "merge the two given options" do
      default_options = [class: "form-label"]
      custom_options = [placeholder: "Username"]

      merged_options = Input.merge_options(default_options, custom_options)

      assert merged_options == [class: "form-label", placeholder: "Username"]
    end

    test "concat classes when there are classes in both options" do
      default_options = [class: "form-label"]
      custom_options = [class: "my-custom-class"]

      merged_options = Input.merge_options(default_options, custom_options)

      assert merged_options == [class: "my-custom-class form-label"]
    end
  end
end
