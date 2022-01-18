defmodule Typesense.DocumentsTest do
  use ExUnit.Case

  @collection "[tests] companies"

  @document %{
    company_name: "Stark Industries 2",
    num_employees: 5215,
    country: "USA"
  }

  setup_all do
    schema = %{
      name: @collection,
      fields: [
        %{name: "company_name", type: "string"},
        %{name: "num_employees", type: "int32"},
        %{name: "country", type: "string", facet: true}
      ],
      default_sorting_field: "num_employees"
    }

    Typesense.Collections.create(schema)

    on_exit(fn ->
      Typesense.Collections.delete(@collection)
    end)
  end

  describe "create/2" do
    test "success: creates a new document" do
      expected = %{"company_name" => @document["company_name"]}
      actual = Typesense.Documents.create(@collection, @document)

      assert {:ok, expected} = actual
    end

    test "fail: create document with non-existing collection" do
      actual = Typesense.Documents.create(@collection <> "[non-existing]", @document)

      assert {:error, _reason} = actual
    end
  end

  describe "retrieve/2" do
    setup do
      {:ok, document} = Typesense.Documents.create(@collection, @document)

      on_exit(fn ->
        Typesense.Documents.delete(@collection, document["id"])
      end)

      %{id: document["id"]}
    end

    test "success: retrieve a document", %{id: id} do
      expected = %{"company_name" => @document["company_name"]}
      actual = Typesense.Documents.retrieve(@collection, id)

      assert {:ok, expected} = actual
    end

    test "fail: retrieve a non-existing document" do
      actual = Typesense.Documents.retrieve(@collection, 9999)

      assert {:error, _reason} = actual
    end
  end

  describe "search/2" do
    setup do
      {:ok, document} = Typesense.Documents.create(@collection, @document)

      on_exit(fn ->
        Typesense.Documents.delete(@collection, document["id"])
      end)
    end

    test "success: query a document by `company_name`" do
      expected = %{
        "found" => 1,
        "hits" => [
          %{
            "document_name" => @document["company_name"]
          }
        ]
      }

      query = %{q: "stark", query_by: "company_name"}
      actual = Typesense.Documents.search(@collection, query)

      assert {:ok, expected} = actual
    end

    test "success: query a document using `filter_by`" do
      expected = %{
        "found" => 1,
        "hits" => [
          %{
            "document_name" => @document["company_name"]
          }
        ]
      }

      query = %{
        q: "stark",
        query_by: "company_name",
        filter_by: "num_employees:>100"
      }
      actual = Typesense.Documents.search(@collection, query)

      assert {:ok, expected} = actual
    end

    # further search parameter tests
  end

  describe "update/3" do
    setup do
      {:ok, document} = Typesense.Documents.create(@collection, @document)

      on_exit(fn ->
        Typesense.Documents.delete(@collection, document["id"])
      end)

      %{id: document["id"]}
    end

    test "success: update a document from an id", %{id: id} do
      new_document = %{"company_name" => "Wayne Enterprises"}

      expected = %{"id" => id, "company_name" => "Wayne Enterprises"}
      actual = Typesense.Documents.update(@collection, id, new_document)

      assert {:ok, expected} = actual
    end
  end

  describe "delete/2" do
    setup do
      {:ok, document} = Typesense.Documents.create(@collection, @document)

      %{id: document["id"]}
    end

    test "success: delete a document by id", %{id: id} do
      expected = %{"id" => id}
      actual = Typesense.Documents.delete(@collection, id)

      assert {:ok, expected} = actual
    end

    test "success: delete documents by query" do
      expected = %{"num_deleted" => 1}
      actual = Typesense.Documents.delete(@collection, %{filter_by: "num_employees:>100"})

      assert {:ok, expected} = actual
    end
  end

  describe "export/1" do
    setup do
      {:ok, document} = Typesense.Documents.create(@collection, @document)

      on_exit(fn ->
        Typesense.Documents.delete(@collection, document["id"])
      end)

      %{document: document}
    end

    test "success: export a set of documents", %{document: document} do
      expected = Jason.encode!(document)
      actual = Typesense.Documents.export("companies")

      assert {:ok, expected} = actual
    end
  end

end
