defmodule LofiPlay.Preview.Bootstrap do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML.Tag

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

  defp input(type, texts, value \\ nil) do
    Tag.content_tag(:div, class: "form-group") do
      Tag.content_tag(:label, [
        Enum.join(texts, ""),
        " ",
        Tag.tag(:input, type: type, class: "form-control", value: value)
      ])
    end
  end

  defp textarea(texts, lines \\ 1) do
    Tag.content_tag(:div, class: "form-group") do
      Tag.content_tag(:label, [
        Enum.join(texts, ""),
        " ",
        Tag.content_tag(:textarea, '', class: "form-control", rows: lines)
      ])
    end
  end

  @doc """
  Enter email #email
  """
  defp preview(%Lofi.Element{tags: %{"email" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    input("email", texts)
  end

  @doc """
  Enter password #password
  """
  defp preview(%Lofi.Element{tags: %{"password" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    input("password", texts)
  end

  @doc """
  Favorite number #number
  """
  defp preview(%Lofi.Element{tags: %{"number" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    input("number", texts, get_content_tag(tags, "default"))
  end

  @doc """
  Date of birth #date
  """
  defp preview(%Lofi.Element{tags: %{"date" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    input("date", texts)
  end

  @doc """
  Last signed in #time
  """
  defp preview(%Lofi.Element{tags: %{"time" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    value = cond do
      has_flag_tag(tags, "now") ->
        Time.utc_now
        |> Map.put(:microsecond, {0, 0}) # Remove extra precision that <input type="time"> does not like
      true ->
        nil
    end
    input("time", texts, value)
  end

  @doc """
  Enter message #text #lines: 6
  """
  defp preview(%Lofi.Element{tags: %{"text" => {:flag, true}, "lines" => {:content, lines_element}}}, %Lofi.Element{texts: texts, tags: tags}) do
    %{texts: [lines_string]} = lines_element
    textarea(texts, lines_string)
  end

  @doc """
  Enter message #text
  """
  defp preview(%Lofi.Element{tags: %{"text" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    input("text", texts, get_content_tag(tags, "default"))
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

    input(type, texts, get_content_tag(tags, "default"))
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
      Tag.content_tag(:select, class: "form-control") do
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