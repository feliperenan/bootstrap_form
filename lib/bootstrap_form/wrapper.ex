defmodule BootstrapForm.Wrapper do
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @doc """
  Build a wrapper tag to the given block.

  wrapper_options - HTML attributes that will be used in the wrapper.
  input_options   - HTML attributes that will be used in the given block (the input).

  If a hint option is provided by input_options, the wrapper will be generated with a <small> tag.

  ## Examples

      build_tag([class: "wrapper-class"], [class: "child-class"]) do
        text_input(:user, name)
      end
      # => <div class="wrapper-class">
             <input class="child-class" id="user_name" name="user[name]" type="text">
           </div>
  """
  def build_tag(wrapper_options, input_options, do: block)
      when is_list(wrapper_options) and is_list(input_options) do
    case Keyword.fetch(input_options, :hint) do
      {:ok, hint} ->
        content_tag(:div, wrapper_options) do
          [
            block,
            content_tag(:small, hint, class: "text-muted")
          ]
        end

      :error ->
        content_tag(:div, wrapper_options) do
          [
            block
          ]
        end
    end
  end
end
