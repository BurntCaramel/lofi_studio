defmodule LofiPlay.Preview.Utilities do
  @doc """
  Flattens a list of class name / boolean tuples into a single class string

      iex> flatten_classes [{"btn", true}, {"active", false}, {"btn-primary", true}]
      "btn btn-primary"
  """
  def flatten_classes(classes) do
    classes
    |> Enum.filter(&(Kernel.elem(&1, 1))) # Keep where .1 is true
    |> Enum.map(&(Kernel.elem(&1, 0))) # Extract class name strings
    |> Enum.join(" ")
  end
end