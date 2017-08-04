defmodule LofiPlay.Preview.Bootstrap do
  alias Phoenix.HTML.Tag

  defp has_flag_tag(tags, name) do
    case tags do
      %{^name => {:flag, true}} -> true
      _ -> false
    end
  end

  @doc """
  Flattens a list of class name / boolean tuples into a single class string

      iex> flatten_classes [{"btn", true}, {"active", false}, {"btn-primary", true}]
      "btn btn-primary"
  """
  defp flatten_classes(classes) do
    classes
    |> Enum.filter(&(Kernel.elem(&1, 1)))
    |> Enum.map(&(Kernel.elem(&1, 0)))
    |> Enum.join(" ")
  end

  @doc """
  #button
  - First
  - Second
  
  <div class="btn-group">
    <button>First</button>
    <button>Second</button>
  </div>
  """
  defp preview(%Lofi.Element{texts: [""], tags: %{"button" => {:flag, true}}}, %Lofi.Element{children: children, tags: tags}) do
    class = flatten_classes [
      {"btn", true},
      {
        cond do
          has_flag_tag(tags, "primary") -> "btn-primary"
          true -> "btn-default"
        end,
        true
      }
    ]

    #Tag.content_tag(:button, Enum.join([""], ""), class: class)
    Tag.content_tag(:div, class: "btn-group") do
      children
      #|> Enum.map(&preview_element/1)
      |> Enum.map(fn (element) ->
        element = Map.update!(element, :tags, fn (child_tags) -> Map.merge(tags, child_tags) end)
        #|> &Map.update!(&1, :tags, &Map.merge(tags, &1))
        preview_element(element)
      end)
    end
  end

  @doc """
  Click me #button
  
  <button>Click me</button>
  """
  defp preview(%Lofi.Element{tags: %{"button" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    class = flatten_classes [
      {"btn", true},
      {"active", has_flag_tag(tags, "active")},
      {
        cond do
          has_flag_tag(tags, "primary") -> "btn-primary"
          true -> "btn-default"
        end,
        true
      }
    ]

    Tag.content_tag(:button, Enum.join(texts, ""), class: class)
  end

  @doc """
  #field
  
  <input>
  """
  defp preview(%Lofi.Element{tags: %{"field" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    type = cond do
      has_flag_tag(tags, "password") ->
        "password"
      has_flag_tag(tags, "email") ->
        "email"
      true ->
        "text"
    end

    Tag.content_tag(:div, class: "form-group") do
      Tag.content_tag(:label, [
        Enum.join(texts, ""),
        " ",
        Tag.tag(:input, type: type, class: "form-control")
      ])
    end
  end

  @doc """
  Accept terms #choice
  
  <label><input type="checkbox"> Accept terms</label>
  """
  defp preview(%Lofi.Element{children: [], tags: %{"choice" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    Tag.content_tag(:label, [
      Tag.tag(:input, type: "checkbox"),
      " ",
      Enum.join(texts, "")
    ])
  end

  @doc """
  Multiple choice #choice
  - Australia
  - India
  - New Zealand
  
  <label>Multiple choice <select><option>Australia</option><option>India</option><option>New Zealand</option></select></label>
  """
  defp preview(%Lofi.Element{tags: %{"choice" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags, children: children}) do
    Tag.content_tag(:label, [
      Enum.join(texts, ""),
      " ",
      Tag.content_tag(:select) do
        Enum.map(children, fn (%Lofi.Element{texts: texts}) ->
          Tag.content_tag(:option, Enum.join(texts, ""))
        end)
      end
    ])
  end

  @doc """
      Hello #primary
      <h1>Hello</h1>

      Hello #secondary
      <h2>Hello</h2>

      Hello
      <p>Hello</p>
  """
  defp preview(%Lofi.Element{children: []}, %Lofi.Element{texts: texts, tags: tags}) do
    tag = cond do
      has_flag_tag(tags, "primary") ->
        :h1
      has_flag_tag(tags, "secondary") ->
        :h2
      true ->
        :p
    end
    
    Tag.content_tag(tag, Enum.join(texts, ""))
  end

  @doc """
  - Australia
  - India
  - New Zealand
  
  <ul>
    <li>Australia</li>
    <li>India</li>
    <li>New Zealand</li>
  </ul>
  """
  defp preview(%Lofi.Element{texts: texts, tags: %{}}, %Lofi.Element{children: children, tags: tags}) do
    tag = cond do
      Map.get(tags, "ordered") == {:flag, true} -> :ol
      true -> :ul
    end

    Tag.content_tag(:div, [
      Enum.join(texts, ""), # Ignore text?
      " ",
      Tag.content_tag(tag) do
        Enum.map(children, fn (element) ->
          Tag.content_tag(:li, preview_element(element))
        end)
      end
    ])
  end

  defp preview_element(element) do
    preview(element, element)
  end

  defp preview_section(lines) do
    html_lines = Enum.map(lines, &preview_element/1)

    Tag.content_tag(:div, html_lines)
  end

  def preview_text(text) do
    sections = Lofi.Parse.parse_sections(text)

    Enum.map(sections, &preview_section/1)
  end
end