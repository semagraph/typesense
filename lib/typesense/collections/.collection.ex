defmodule Typesense.Collections.Collection do
  @moduledoc """
  Represents a Typesense Collection schema.
  """

  @enforce_keys [:name, :fields]

  defstruct [
    :id,
    :name,
    :fields,
    :token_seperators,
    :symbols_to_index,
    :default_sorting_field
  ]

  #@type t :: %Collection{
  #  id: Int.t(),
  #  name: String.t(),
  #}
end
