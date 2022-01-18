defmodule Typesense.Utilities do
  @moduledoc false
  def to_query_string(map) do
    map
    |> Map.to_list
    |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
    |> Enum.join("&")
  end
end
