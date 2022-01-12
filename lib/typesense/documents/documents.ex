defmodule Typesense.Documents do
  @moduledoc """
  Documentation for `Typesense.Documents`
  """

  require Logger

  @doc """
  Index a document.

  ## Examples
  iex> document = %{
    id: "124",
    company_name: "Stark Industries",
    num_employees: 5215,
    country: "USA"
  }
  iex> Typesense.Documents.create(collection, document)
  {:ok, document}
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
  iex> args = %{
    limit_multi_searches
  } 
  iex> Typesense.Documents.retrieve(collection, id)
  {:ok, document}
  """
  def retrieve(collection, id, args) do
    response = Typesense.get("/collections/#{collection}/documents/#{id}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Search for documents.


  ## Examples
  iex> search_params = %{
    q: "stark",
    query_by: "company_name",
    filter_by: "num_employees:>100",
    sort_by: "num_employees:desc"
  }
  iex> Typesense.Documents.search(collection, search_params)
  iex> {:ok, documents}
  """
  def search(collection, search_params) do
    query_string =
      search_params
      |> Map.to_list
      |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
      |> Enum.join("&")

    response = Typesense.get("/collections/#{collection}/documents/search?#{query_string}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Update a document.

  ## Examples
  iex> Typesense.Documents.update(collection, id, document)
  {:ok, document}
  """
  def update(collection, id, document) do
    response = Typesense.update("/collections/#{collection}/documents/#{id}", document)

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Delete a document.

  ## Examples
  iex> Typesense.Documents.delete(collection, id)
  {:ok, _document}
  """
  def delete(collection, id) do
    response = Typesense.delete("/collections/#{collection}/documents/#{id}")

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Export documents from a collection.

  ## Examples
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
  iex> documents = [{
    id: "124",
    company_name: "Stark Industries",
    num_employees: 5215,
    country: "USA"
  }]
  iex> Typesense.Documents.import(collection, documents)
  :ok
  """
  def import(collection, documents, opts \\ []) do
    response = Typesense.post("/collections/#{collection}/documents/import?action=create", documents, headers: [{"content-type", "text/plain"}])

    case response do
      {:ok, env} -> Typesense.Http.handle_response(env)
      {:error, reason} -> {:error, reason}
    end
  end
end
