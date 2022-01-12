defmodule Typesense.Keys do
  @moduledoc """
  The `Typesense.Keys` module is the service implementation for Typesense' `Keys` API Resource

  This module allows you to create API Keys with fine-grain access-control. It enables restriction of access on both a per-collection and per-action level.
  """

  @doc """
  Create an API key.

  ## Examples

  ```elixir
  schema = %{
    description: "Admin key.",
    actions: ["*"],
    collections: ["*"]
  }
  Typesense.Keys.create(schema)
  ```
  """
end
