defmodule BootstrapForm.InputBuilderTest do
  use ExUnit.Case

  alias BootstrapForm.InputBuilder

  doctest InputBuilder

  describe "build/4" do
    test "raise error when an unknow type is given" do
      assert_raise RuntimeError, "type: :unknow is not yet implemented", fn ->
        InputBuilder.build(:unknow, :user, :name)
      end
    end
  end
end
