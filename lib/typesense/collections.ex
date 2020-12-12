defmodule Typesense.Collections do
  @moduledoc """
  Documentation for `Typesense`.
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://localhost:8108"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}, {"X-TYPESENSE-API-KEY", "some-api-key"}]
  plug Tesla.Middleware.JSON

  @doc """
  Create a collection.

  ## Examples
  iex> schema = %{
    name: "creators",
    fields: [
      %{name: "name", type: "string"},
      %{name: "subscribers", type: "int32"},
    ],
    default_sorting_field: "subscribers"
  }
  iex> Typesense.Collections.create(schema)
  {:ok, collection}
  """
  def create(schema) do
    post("/collections", schema)
  end

  @doc """
  Retrieve all collections.

  ## Examples
  iex> Typesense.Collections.retrieve()
  [%{}, ...]
  """
  def retrieve do
    get("/collections")
  end

  @doc """
  Drop a collection.

  ## Examples
  iex> Typesense.Collections.drop(collection_id)
  {:ok, _collection}
  """
  def drop(collection) do
    delete("/collections/#{collection}")
  end

  @doc """
  Search a collection.

  ## Examples
  iex> Typesense.Collections.search(collection, query_params)
  [%{}, ...]
  """
  def search(collection, query_params) do
    get("/collections/#{collection}/documents/search", query: query_params)
  end

end
