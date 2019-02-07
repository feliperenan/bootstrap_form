defmodule BootstrapForm.Wrapper do
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  alias BootstrapForm.Input

  @doc """
  Build a wrapper tag to the given block.

  wrapper_options - HTML attributes that will be used in the wrapper.
  input_options   - HTML attributes that will be used in the given block (the input).

  If a hint option is provided by input_options, the wrapper will be generated with a <small> tag.

  ## Examples

      build_tag(%Input{wrapper_options: "wrapper-class"}) do
        text_input(:user, name)
      end
      # => <div class="wrapper-class">
             <input class="child-class" id="user_name" name="user[name]" type="text">
           </div>
  """
  def build_tag(%Input{hint: nil, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block
      ]
    end
  end

  def build_tag(%Input{hint: hint, wrapper_options: wrapper_options}, do: block) do
    content_tag(:div, wrapper_options) do
      [
        block,
        content_tag(:small, hint, class: "text-muted")
      ]
    end
  end
end
