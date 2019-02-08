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
end
