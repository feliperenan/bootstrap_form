defmodule BootstrapForm.Wrapper do
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  alias BootstrapForm.Input

  @doc """
  Build a wrapper tag to the given block.

  * If a hint option is provided by input, the wrapper will be generated with a <small> tag.
  * If the input has errors, the wrapper will be generated with a <div> tag for each error.

  ## Examples

      build_tag(%Input{wrapper_options: "wrapper-class"}) do
        text_input(:user, name)
      end
      # => <div class="wrapper-class">
             <input class="child-class" id="user_name" name="user[name]" type="text">
           </div>

      build_tag(%Input{errors: ["error"], hint: "Some hint"}) do
        text_input(:user, name)
      end
      # => <div class="wrapper-class">
             <input class="child-class" id="user_name" name="user[name]" type="text">
             <div class="invalid-feedback">error</div>
             <small class="text-muted">Some hint</small>
           </div>

  """
  def build_tag(%Input{errors: nil, hint: nil, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block
      ]
    end
  end

  def build_tag(%Input{errors: nil, hint: hint, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block,
        content_tag(:small, hint, class: "text-muted")
      ]
    end
  end

  def build_tag(%Input{errors: errors, hint: nil, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block,

        for error <- errors do
          content_tag(:div, error, class: "invalid-feedback")
        end
      ]
    end
  end

  def build_tag(%Input{errors: errors, hint: hint, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block,

        for error <- errors do
          content_tag(:div, error, class: "invalid-feedback")
        end,

        content_tag(:small, hint, class: "text-muted")
      ]
    end
  end
end
