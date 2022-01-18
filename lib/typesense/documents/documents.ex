defmodule Typesense.Documents do
  @moduledoc """
  The `Typesense.Documents` module is the service implementation for Typesense' `Documents` API Resource.
  """

  @doc """
  Index a document.

  ## Examples

  ```elixir
  iex> document = %{
    company_name: "Stark Industries",
    num_employees: 5215,
    country: "USA"
  }
  iex> Typesense.Documents.create(collection, document)
  {:ok, document}
  ```
  """
  def create(collection, document) do
    response = Typesense.post("/collections/#{collection}/documents", document)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Retrieve a document.

  ## Examples

  ```elixir
  iex> args = %{
    limit_multi_searches
  }
  iex> Typesense.Documents.retrieve(collection, id)
  {:ok, document}
  ```
  """
  def retrieve(collection, id) do
    response = Typesense.get("/collections/#{collection}/documents/#{id}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Search for documents.

  ## Examples

  ```elixir
  iex> search_params = %{
    q: "stark",
    query_by: "company_name",
    filter_by: "num_employees:>100",
    sort_by: "num_employees:desc"
  }
  iex> Typesense.Documents.search(collection, search_params)
  iex> {:ok, documents}
  ```
  """
  def search(collection, search_params) do
    query_string = Typesense.Utilities.to_query_string(search_params)

    response = Typesense.get("/collections/#{collection}/documents/search", query: search_params)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Update a document.

  ## Examples

  ```elixir
  iex> Typesense.Documents.update(collection, id, document)
  {:ok, document}
  ```
  """
  def update(collection, id, document) do
    response = Typesense.patch(
      "/collections/#{collection}/documents/#{id}",
      document,
      headers: [{"content-type", "application/json"}]
    )

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Delete a document.

  ## Options

  * `:id` - The `id` of the document to be deleted
  * `:query` - The `map` of params to filter the delete by

  ## Examples

  ```elixir
  iex> Typesense.Documents.delete(collection, id \\\\ nil, query \\\\ %{})
  {:ok, _document}
  ```
  """
  def delete(collection, id) when ( is_integer(id) or is_binary(id) ) do
    response = Typesense.delete("/collections/#{collection}/documents/#{id}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  def delete(collection, query) when is_map(query) do
    response = Typesense.delete("/collections/#{collection}/documents", query: query)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Export documents from a collection.

  ## Examples

  ```elixir
  iex> Typesense.Documents.export(collection)
  [%{}, ...]
  """
  def export(collection) do
    response = Typesense.get("/collections/#{collection}/documents/export")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Import documents into a collection.

  ## Examples

  ```elixir
  iex> documents = [{
    id: "124",
    company_name: "Stark Industries",
    num_employees: 5215,
    country: "USA"
  }]
  iex> Typesense.Documents.import(collection, documents, :create)
  {:ok, documents}
  """
  def import(collection, documents, action \\ :create) do
    response = Typesense.post("/collections/#{collection}/documents/import?action=#{action}", documents, headers: [{"content-type", "text/plain"}])

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end
end
