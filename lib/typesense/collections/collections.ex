defmodule Typesense.Collections do
  @moduledoc """
  The `Typesense.Collections` module is the service implementation for Typesense' `Collections` API Resource.
  """

  alias Typesense.Collections.Collection

  @doc """
  Create a Collection.

  ## Examples

  ```
  schema = %{
    name: "companies",
    fields: [
      %{name: "company_name", type: "string"},
      %{name: "num_employees", type: "int32"},
      %{name: "country", type: "string", facet: true},
    ],
    default_sorting_field: "num_employees"
  }
  Typesense.Collections.create(schema)
  ```
  """
  def create(schema) do
    response = Typesense.post("/collections", schema)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Retrieve all collections.

  ## Examples
  iex> Typesense.Collections.retrieve("companies")
  {:ok, company}
  """
  def retrieve(collection) do
    response = Typesense.get("/collections/#{collection}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  List all collections.

  ## Examples
  iex> Typesense.Collections.list()
  {:ok, collections}
  """
  def list() do
    response = Typesense.get("/collections")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Drop a collection.

  ## Examples
  iex> Typesense.Collections.drop(collection_id)
  {:ok, _collection}
  """
  def drop(collection) do
    response = Typesense.delete("/collections/#{collection}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Search a collection.

  ## Examples
  iex> Typesense.Collections.search(collection, query_params)
  [%{}, ...]
  """
  def search(collection, query_params) do
    response = Typesense.get("/collections/#{collection}/documents/search", query: query_params)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

end
