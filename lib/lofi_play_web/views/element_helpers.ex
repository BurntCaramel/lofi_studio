defmodule LofiPlayWeb.ElementHelpers do

  @moduledoc """
  Conveniences for elements.
  """

  use Phoenix.HTML

  @doc """
  Render a link, with different classes dependending whether current page or not
  """
  def active_link(conn, text, active_class, inactive_class, opts) do
    to = Keyword.fetch!(opts, :to)
    current = if conn.query_string == "" do
      conn.request_path
    else
      "#{conn.request_path}?#{conn.query_string}"
    end
    active? = current == String.rstrip(to, ?/)
    class = if active?, do: active_class, else: inactive_class
    link text, to: to, class: class
  end
end
