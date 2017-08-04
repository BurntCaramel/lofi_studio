defmodule LofiPlay.Preview.Lofi do
  def has_flag_tag(tags, name) do
    case tags do
      %{^name => {:flag, true}} -> true
      _ -> false
    end
  end

  def get_content_tag(tags, name, default \\ nil) do
    case tags do
      %{^name => {:content, %{texts: texts}}} ->
        Enum.join(texts, "")
      _ ->
        default
    end
  end

  def fetch_content_tag(tags, name) do
    case tags do
      %{^name => {:content, %{texts: texts}}} ->
        {:ok, Enum.join(texts, "")}
      %{^name => _value} ->
        {:error, :not_content}
      _ ->
        {:error, :missing}
    end
  end
end