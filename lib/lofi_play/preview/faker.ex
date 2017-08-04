defmodule LofiPlay.Preview.Faker do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML.Tag

  @doc """
  Enter email #email
  """
  defp preview(%Lofi.Element{tags: %{"email" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    {
      Enum.join(texts, ""),
      Faker.Internet.safe_email
    }
  end

  @doc """
  Enter password #password
  """
  defp preview(%Lofi.Element{tags: %{"password" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    {
      Enum.join(texts, ""),
      ""
    }
  end

  @doc """
  Favorite number #number
  """
  defp preview(%Lofi.Element{tags: %{"number" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    value =
      with {:ok, string} <- fetch_content_tag(tags, "default"),
        {number, _remainder} <- Integer.parse(string)
      do
        number
      else
        _ -> :crypto.rand_uniform(1, 1001)
    end
    
    {
      Enum.join(texts, ""),
      value
    }
  end

  @doc """
  Date of birth #date
  """
  defp preview(%Lofi.Element{tags: %{"date" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    value = Faker.Date.date_of_birth

    {
      Enum.join(texts, ""),
      value
    }
  end

  # @doc """
  # Last signed in #time
  # """
  defp preview(%Lofi.Element{tags: %{"time" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    value = cond do
      has_flag_tag(tags, "now") ->
        DateTime.utc_now
        |> Map.put(:microsecond, {0, 0}) # Remove extra precision that <input type="time"> does not like
        |> DateTime.to_unix

      true ->
        Faker.DateTime.backward(100)
        |> DateTime.to_unix
    end

    {
      Enum.join(texts, ""),
      value
    }
  end

  # @doc """
  # Enter message #text #lines: 6
  # """
  # defp preview(%Lofi.Element{tags: %{"text" => {:flag, true}, "lines" => {:content, lines_element}}}, %Lofi.Element{texts: texts, tags: tags}) do
  #   %{texts: [lines_string]} = lines_element
  #   textarea(texts, lines_string)
  # end

  # @doc """
  # Enter message #text
  # """
  # defp preview(%Lofi.Element{tags: %{"text" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
  #   input("text", texts, get_content_tag(tags, "default"))
  # end

  @doc """
  Accept terms #choice
  """
  defp preview(%Lofi.Element{children: [], tags: %{"choice" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags}) do
    value = if :crypto.rand_uniform(0, 2) == 1 do
      true
    else
      false
    end

    {
      Enum.join(texts, ""),
      value
    }
  end

  @doc """
  Multiple choice #choice
  - Australia
  - India
  - New Zealand
  """
  defp preview(%Lofi.Element{tags: %{"choice" => {:flag, true}}}, %Lofi.Element{texts: texts, tags: tags, children: children}) do
    index = :crypto.rand_uniform(0, Enum.count(children))
    %Lofi.Element{texts: child_texts} = Enum.at(children, index)
    value = Enum.join(child_texts, "")

    {
      Enum.join(texts, ""),
      value
    }
  end

  @doc """
      Hello #text
  """
  defp preview(%Lofi.Element{children: []}, %Lofi.Element{texts: texts, tags: tags}) do
    {
      Enum.join(texts, ""),
      Faker.Lorem.sentence(1..3)
    }
  end

  @doc """
  - Australia
  - India
  - New Zealand
  """
  defp preview(%Lofi.Element{texts: texts, tags: %{}}, %Lofi.Element{children: children, tags: tags}) do
    {
      Enum.join(texts, ""),
      nil
    }
  end

  defp preview_element(element, map) do
    {key, value} = preview(element, element)
    Map.put(map, key, value)
  end

  defp preview_section(lines) do
    #map = Enum.map(lines, &preview_element/1)
    map = List.foldl(lines, %{}, &preview_element/2)

    json_string = Poison.encode!(map, pretty: true)

    Tag.content_tag(:pre, json_string)
  end

  def preview_text(text) do
    sections = Lofi.Parse.parse_sections(text)

    Enum.map(sections, &preview_section/1)
  end
end