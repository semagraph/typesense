defmodule Typesense.Documents do
  @moduledoc """
  Documentation for `Typesense.Documents`
  """
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://localhost:8108"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla"}, {"X-TYPESENSE-API-KEY", "some-api-key"}]
  plug Tesla.Middleware.JSON

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
    post("/collections/#{collection}/documents", document)
  end

  @doc """
  Retrieve a document.

  ## Examples
  iex> Typesense.Documents.retrieve(collection, id)
  {:ok, document}
  """
  def retrieve(collection, id) do
    get("/collections/#{collection}/documents/#{id}")
  end

  @doc """
  Update a document.

  ## Examples
  iex> Typesense.Documents.update(collection, id, document)
  {:ok, document}
  """
  def update(collection, id, document) do
    patch("/collections/#{collection}/documents/#{id}", document)
  end

  @doc """
  Delete a document.

  ## Examples
  iex> Typesense.Documents.delete(collection, id)
  {:ok, _document}
  """
  def delete(collection, id) do
    delete("/collections/#{collection}/documents/#{id}")
  end

  @doc """
  Export documents from a collection.

  ## Examples
  iex> Typesense.Documents.export(collection)
  [%{}, ...]
  """
  def export(collection) do
    get("/collections/#{collection}/documents/export")
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
  def import(collection, documents) do
    post("/collections/#{collection}/documents/import?action=create", documents)
  end
end
